Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTLAQZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 11:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTLAQZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 11:25:23 -0500
Received: from pop.gmx.de ([213.165.64.20]:63176 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263606AbTLAQZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 11:25:14 -0500
Date: Mon, 1 Dec 2003 17:25:13 +0100 (MET)
From: "Juergen Oberhofer" <j.oberhofer@gmx.at>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary307301070295913"
Subject: wake_up_interruptible problem
X-Priority: 3 (Normal)
X-Authenticated: #2614397
Message-ID: <30730.1070295913@www47.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary307301070295913
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
I'm trying to implement a timer, which on each timer interrupt wakes up
every process that got blocked by a read call. 
My problem is the following: if I'm insmod'ing the module (I've attached the
file) the execution gets
blocked on the wake_up_interruptible(&timer_queue); call. If I'm
uncommenting this line everything
goes smooth and the timer counts without problems. Does somebody have a
hint? Some ideas?
Regards
Juergen

void timerEvent(unsigned long arg)
{
    tick_count++;
   wake_up_interruptible(&timer_queue);
    timer.expires= jiffies + timer_delay;
    add_timer(&timer);
}

int __init init_timer_module(void)
{
    /* Create the proc entry and make it readable and writeable by all -
0666 */
    timer_file = create_proc_entry("timer", 0666, NULL);
    if (timer_file == NULL) {
        return -ENOMEM;
    }

    /* Set timer_file fields */
    timer_file->read_proc = &proc_read_timer;
    timer_file->write_proc = &proc_write_timer;
    timer_file->owner = THIS_MODULE;

    SET_MODULE_OWNER(&timer_fops);

    /* register /dev/tick */
    register_chrdev(TICK_MAJOR, "tick", &timer_fops);

    init_timer(&timer);
    timer.expires= jiffies + timer_delay;
    timer.function=timerEvent;
    timer.data=42;
    add_timer(&timer);

    /* everything initialized */
    printk(KERN_INFO "%s %s initialized\n", MODULE_NAME, MODULE_VERSION);
    return 0;
}

-- 
HoHoHo! Seid Ihr auch alle schön brav gewesen?

GMX Weihnachts-Special: Die 1. Adresse für Weihnachts-
männer und -frauen! http://www.gmx.net/de/cgi/specialmail

+++ GMX - die erste Adresse für Mail, Message, More! +++
--========GMXBoundary307301070295913
Content-Type: text/plain; name="amu_timer.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="amu_timer.c"

LyoNCiAqIGFtdV9tb2R1bGUuYyBpcyBiYXNlZCBvbiBwcm9jZnNfZXhhbXBsZS5jIGJ5IEVyaWsg
TW91dy4NCiAqIEZvciBtb3JlIGluZm9ybWF0aW9uLCBwbGVhc2Ugc2VlIFRoZSBMaW51eCBLZXJu
ZWwgUHJvY2ZzIEd1aWRlLA0KICogaHR0cDovL2tlcm5lbG5ld2JpZXMub3JnL2RvY3VtZW50cy9r
ZG9jL3Byb2Nmcy1ndWlkZS9sa3Byb2Nmc2d1aWRlLmh0bWwNCiAqDQogKiBKLkouIEJvb3IsIEFp
bVN5cyBidg0KICogICBodHRwOi8vd3d3LmFpbXN5cy5ubA0KICogICBqamJvb3JAYWltc3lzLm5s
DQogKi8NCg0KLyoNCiR7Q1JPU1NfQ09NUElMRX1nY2MgLU8yIC1EX19LRVJORUxfXyAtRE1PRFVM
RSBhbXVfdGltZXIuYyAtbyBhbXVfdGltZXIubw0KDQoqLw0KDQoNCiNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCiNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiNpbmNsdWRlIDxsaW51eC9pbml0
Lmg+DQojaW5jbHVkZSA8bGludXgvcHJvY19mcy5oPg0KI2luY2x1ZGUgPGxpbnV4L2ZzLmg+DQoj
aW5jbHVkZSA8YXNtL3VhY2Nlc3MuaD4NCg0KI2RlZmluZSBUSUNLX01BSk9SICAgICAgMjQxDQoN
CiNkZWZpbmUgTU9EVUxFX1ZFUlNJT04gIjAuMSINCiNkZWZpbmUgTU9EVUxFX05BTUUgInRpbWVy
Ig0KDQpzdGF0aWMgc3RydWN0IHByb2NfZGlyX2VudHJ5ICp0aW1lcl9maWxlOw0KDQpzdGF0aWMg
c3RydWN0IHRpbWVyX2xpc3QgdGltZXI7DQpzdGF0aWMgdW5zaWduZWQgbG9uZyB0aWNrX2NvdW50
ID0gMDsNCnN0YXRpYyBpbnQgdGltZXJfZGVsYXkgPSAxOw0KDQpERUNMQVJFX1dBSVRfUVVFVUVf
SEVBRCh0aW1lcl9xdWV1ZSk7DQoNCmludCB0aW1lcl9vcGVuKHN0cnVjdCBpbm9kZSogaW5vZGUs
IHN0cnVjdCBmaWxlKiBmaWxwKTsNCnNzaXplX3QgdGltZXJfcmVhZCAoc3RydWN0IGZpbGUgKmZp
bHAsIGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKmZfcG9zKTsNCmludCB0aW1lcl9y
ZWxlYXNlKHN0cnVjdCBpbm9kZSogaW5vZGUsIHN0cnVjdCBmaWxlKiBmaWxwKTsNCg0Kc3RhdGlj
IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgdGltZXJfZm9wcyA9IHsNCiAgICBvcGVuOiB0aW1lcl9v
cGVuLA0KICAgIHJlYWQ6IHRpbWVyX3JlYWQsDQogICAgcmVsZWFzZTogdGltZXJfcmVsZWFzZQ0K
fTsNCg0Kc3RhdGljIGludCBwcm9jX3JlYWRfdGltZXIoY2hhciAqcGFnZSwgY2hhciAqKnN0YXJ0
LCBvZmZfdCBvZmYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBjb3VudCwg
aW50ICplb2YsIHZvaWQgKmRhdGEpDQp7DQogICAgaW50IGxlbjsNCiAgICBsZW4gPSBzcHJpbnRm
KHBhZ2UsICJuciBvZiB0aW1lciB0aWNrczogJWx1XG4iLCB0aWNrX2NvdW50KTsNCiAgICByZXR1
cm4gbGVuOw0KfQ0KDQoNCnN0YXRpYyBpbnQgcHJvY193cml0ZV90aW1lcihzdHJ1Y3QgZmlsZSAq
ZmlsZSwgY29uc3QgY2hhciAqYnVmZmVyLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgbG9uZyBjb3VudCwgdm9pZCAqZGF0YSkNCnsNCiAgICByZXR1cm4gMDsNCn0N
Cg0Kdm9pZCB0aW1lckV2ZW50KHVuc2lnbmVkIGxvbmcgYXJnKQ0Kew0KICAgIHRpY2tfY291bnQr
KzsNCiAgICB3YWtlX3VwX2ludGVycnVwdGlibGUoJnRpbWVyX3F1ZXVlKTsNCiAgICB0aW1lci5l
eHBpcmVzPSBqaWZmaWVzICsgdGltZXJfZGVsYXk7DQogICAgYWRkX3RpbWVyKCZ0aW1lcik7DQp9
DQoNCmludCBfX2luaXQgaW5pdF90aW1lcl9tb2R1bGUodm9pZCkNCnsNCiAgICAvKiBDcmVhdGUg
dGhlIHByb2MgZW50cnkgYW5kIG1ha2UgaXQgcmVhZGFibGUgYW5kIHdyaXRlYWJsZSBieSBhbGwg
LSAwNjY2ICovDQogICAgdGltZXJfZmlsZSA9IGNyZWF0ZV9wcm9jX2VudHJ5KCJ0aW1lciIsIDA2
NjYsIE5VTEwpOw0KICAgIGlmICh0aW1lcl9maWxlID09IE5VTEwpIHsNCiAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQogICAgfQ0KICAgIA0KICAgIC8qIFNldCB0aW1lcl9maWxlIGZpZWxkcyAqLw0K
ICAgIHRpbWVyX2ZpbGUtPnJlYWRfcHJvYyA9ICZwcm9jX3JlYWRfdGltZXI7DQogICAgdGltZXJf
ZmlsZS0+d3JpdGVfcHJvYyA9ICZwcm9jX3dyaXRlX3RpbWVyOw0KICAgIHRpbWVyX2ZpbGUtPm93
bmVyID0gVEhJU19NT0RVTEU7DQogICAgDQogICAgU0VUX01PRFVMRV9PV05FUigmdGltZXJfZm9w
cyk7DQogICAgDQogICAgLyogcmVnaXN0ZXIgL2Rldi90aWNrICovDQogICAgcmVnaXN0ZXJfY2hy
ZGV2KFRJQ0tfTUFKT1IsICJ0aWNrIiwgJnRpbWVyX2ZvcHMpOw0KICAgIA0KICAgIGluaXRfdGlt
ZXIoJnRpbWVyKTsNCiAgICB0aW1lci5leHBpcmVzPSBqaWZmaWVzICsgdGltZXJfZGVsYXk7DQog
ICAgdGltZXIuZnVuY3Rpb249dGltZXJFdmVudDsNCiAgICB0aW1lci5kYXRhPTQyOw0KICAgIGFk
ZF90aW1lcigmdGltZXIpOw0KICAgIA0KICAgIC8qIGV2ZXJ5dGhpbmcgaW5pdGlhbGl6ZWQgKi8N
CiAgICBwcmludGsoS0VSTl9JTkZPICIlcyAlcyBpbml0aWFsaXplZFxuIiwgTU9EVUxFX05BTUUs
IE1PRFVMRV9WRVJTSU9OKTsNCiAgICByZXR1cm4gMDsNCn0NCg0Kc3RhdGljIHZvaWQgX19leGl0
IGNsZWFudXBfdGltZXJfbW9kdWxlKHZvaWQpDQp7DQogICAgZGVsX3RpbWVyKCZ0aW1lcik7DQog
ICAgcmVtb3ZlX3Byb2NfZW50cnkoInRpbWVyIiwgTlVMTCk7DQogICAgdW5yZWdpc3Rlcl9jaHJk
ZXYoVElDS19NQUpPUiwgInRpY2siKTsNCiAgICANCiAgICBwcmludGsoS0VSTl9JTkZPICIlcyAl
cyByZW1vdmVkXG4iLCBNT0RVTEVfTkFNRSwgTU9EVUxFX1ZFUlNJT04pOw0KfQ0KDQppbnQgdGlt
ZXJfb3BlbihzdHJ1Y3QgaW5vZGUqIGlub2RlLCBzdHJ1Y3QgZmlsZSogZmlscCkNCnsNCiAgICBy
ZXR1cm4gMDsNCn0NCg0KaW50IHRpbWVyX3JlbGVhc2Uoc3RydWN0IGlub2RlKiBpbm9kZSwgc3Ry
dWN0IGZpbGUqIGZpbHApDQp7DQogICAgcmV0dXJuIDA7DQp9DQoNCnNzaXplX3QgdGltZXJfcmVh
ZCAoc3RydWN0IGZpbGUgKmZpbHAsIGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKmZf
cG9zKQ0Kew0KICAgIC8qIGR1bW15IHJlYWQgdG8gd2FpdCBvbiBrZXJuZWwgdGltZXIgKi8NCiAg
ICB3aGlsZSAoMSkgew0KICAgICAgIGludGVycnVwdGlibGVfc2xlZXBfb24oJnRpbWVyX3F1ZXVl
KTsNCiAgICAgICBpZiAoc2lnbmFsX3BlbmRpbmcgKGN1cnJlbnQpKSAgLyogYSBzaWduYWwgYXJy
aXZlZCAqLw0KICAgICAgICAgICByZXR1cm4gLUVSRVNUQVJUU1lTOyAvKiB0ZWxsIHRoZSBmcyBs
YXllciB0byBoYW5kbGUgaXQgKi8NCiAgICAgICBlbHNlIGJyZWFrOw0KICAgIH0gDQogICAgcmV0
dXJuIDA7DQp9DQoNCiNpZmRlZiBNT0RVTEUNCi8qIGhlcmUgYXJlIHRoZSBjb21waWxlciBtYWNy
b3MgZm9yIG1vZHVsZSBvcGVyYXRpb24gKi8NCm1vZHVsZV9pbml0KGluaXRfdGltZXJfbW9kdWxl
KTsNCm1vZHVsZV9leGl0KGNsZWFudXBfdGltZXJfbW9kdWxlKTsNCiNlbmRpZg0KDQpNT0RVTEVf
QVVUSE9SKCJKLkouIEJvb3IsIEFpbVN5cyBidiIpOw0KTU9EVUxFX0RFU0NSSVBUSU9OKCJ0aW1l
ciBtb2R1bGUiKTsNCk1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCg0KRVhQT1JUX05PX1NZTUJPTFM7
DQoNCg==

--========GMXBoundary307301070295913--

