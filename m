Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132598AbRDHUW6>; Sun, 8 Apr 2001 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132603AbRDHUWs>; Sun, 8 Apr 2001 16:22:48 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:40197 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132598AbRDHUWh>; Sun, 8 Apr 2001 16:22:37 -0400
Message-ID: <3AD0C8AD.1A4D7D12@t-online.de>
Date: Sun, 08 Apr 2001 22:23:09 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
CC: Vojtech Pavlik <vojtech@suse.cz>, linas@linas.org
Subject: Re: mouse problems in 2.4.2 -> lost byte -> Patch(2.4.3)!
In-Reply-To: <20010328235913.A6994@suse.cz> <20010328231933.53ECF1B7A5@backlot.linas.org> <20010329074551.A361@suse.cz>
Content-Type: multipart/mixed;
 boundary="------------56546803550E8F9B818437ED"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------56546803550E8F9B818437ED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Original Problem: PS/2 mouse pointer goes upper right corner and stays there.
Diagnosis: one byte was lost and this is fatal for the mouse driver.

Various people wrote:
> 
> On Wed, Mar 28, 2001 at 05:19:33PM -0600, linas@linas.org wrote:
..
> > > > > > > I am experiencing debilitating intermittent mouse problems & was about
> > > > > >
> > > > > > This is easily explained: some byte of the mouse protocol was lost.
> 
> Plus, it's very likely the new PS/2 code will break on some systems that
> have not-so-compatible i8042 chips, so it is really something that can't


Losing bytes on psaux is a bug!

We must first understand, how bytes can be lost (most probable first):
- transmission error on the line can easily happen in noisy environments
   and is _not_ handled correctly by linux (i.e. should do RESEND)
- 0xAA is always handled as reconnect, if the mouse generates this byte,
   Linux will de-sync the mouse driver
- Mouse is defective or keyboard controller defective
- An error in the linux kbd/mouse driver (e.g. triggered by X11<->console switching)

This patch printk's necessary information on the first 2 cases and
should be applied to the stable kernel, as this will help to resolve a severe bug !

Regards, Gunther

P.S.
These messages can be generated:
Apr  8 21:49:23 linux kernel: psaux: reconnect 0xAA detected
Apr  8 21:49:42 linux kernel: pc_keyb: mouse error (0x75), byte ignored(ff).
Apr  8 21:49:43 linux kernel: psaux: reconnect 0xAA detected


--- linux-2.4.3-orig/drivers/char/pc_keyb.c     Wed Apr  4 19:46:42 2001
+++ linux/drivers/char/pc_keyb.c        Sun Apr  8 21:45:37 2001
@@ -404,6 +404,11 @@
                mouse_reply_expected = 0;
        }
        else if(scancode == AUX_RECONNECT){
+               // Under normal operation most mice don't generate 0xAA.
+               // But, Other devices might be unusable with this policy.
+               //  (My mouse easily generates 0xAAs on rapid movements,
+               //   when set to 10 samples/sec.)
+               printk("psaux: reconnect detected(0xaa), sending AUX_ENABLE.\n");
                queue->head = queue->tail = 0;  /* Flush input queue */
                __aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
                return;
@@ -420,6 +425,9 @@
                        kill_fasync(&queue->fasync, SIGIO, POLL_IN);
                        wake_up_interruptible(&queue->proc_list);
                }
+               else
+                       // 2K buffer is enough for about 10 sec under normal operations, here.
+                       printk("psaux: buffer overflow, byte dropped.\n");
        }
 #endif
 }
@@ -465,6 +473,11 @@
                        else
                                handle_keyboard_event(scancode);
                }
+               else
+                       // Fixme: Ignoring bytes will de-sync mouse protocol.
+                       printk("pc_keyb: %s error (0x%02x), byte ignored(%02x).\n",
+                       (status & KBD_STAT_MOUSE_OBF)?"mouse":"kbd",status,scancode);
+
 
                status = kbd_read_status();
        }
--------------56546803550E8F9B818437ED
Content-Type: application/octet-stream;
 name="gmdiff-lx243-psaux-error-reporting"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gmdiff-lx243-psaux-error-reporting"

LS0tIGxpbnV4LTIuNC4zLW9yaWcvZHJpdmVycy9jaGFyL3BjX2tleWIuYwlXZWQgQXByICA0
IDE5OjQ2OjQyIDIwMDEKKysrIGxpbnV4L2RyaXZlcnMvY2hhci9wY19rZXliLmMJU3VuIEFw
ciAgOCAyMTo0NTozNyAyMDAxCkBAIC00MDQsNiArNDA0LDExIEBACiAJCW1vdXNlX3JlcGx5
X2V4cGVjdGVkID0gMDsKIAl9CiAJZWxzZSBpZihzY2FuY29kZSA9PSBBVVhfUkVDT05ORUNU
KXsKKwkJLy8gVW5kZXIgbm9ybWFsIG9wZXJhdGlvbiBtb3N0IG1pY2UgZG9uJ3QgZ2VuZXJh
dGUgMHhBQS4KKwkJLy8gQnV0LCBPdGhlciBkZXZpY2VzIG1pZ2h0IGJlIHVudXNhYmxlIHdp
dGggdGhpcyBwb2xpY3kuCisJCS8vICAoTXkgbW91c2UgZWFzaWx5IGdlbmVyYXRlcyAweEFB
cyBvbiByYXBpZCBtb3ZlbWVudHMsCisJCS8vICAgd2hlbiBzZXQgdG8gMTAgc2FtcGxlcy9z
ZWMuKQorCQlwcmludGsoInBzYXV4OiByZWNvbm5lY3QgZGV0ZWN0ZWQoMHhhYSksIHNlbmRp
bmcgQVVYX0VOQUJMRS5cbiIpOwogCQlxdWV1ZS0+aGVhZCA9IHF1ZXVlLT50YWlsID0gMDsg
IC8qIEZsdXNoIGlucHV0IHF1ZXVlICovCiAJCV9fYXV4X3dyaXRlX2FjayhBVVhfRU5BQkxF
X0RFVik7ICAvKiBwaW5nIHRoZSBtb3VzZSA6KSAqLwogCQlyZXR1cm47CkBAIC00MjAsNiAr
NDI1LDkgQEAKIAkJCWtpbGxfZmFzeW5jKCZxdWV1ZS0+ZmFzeW5jLCBTSUdJTywgUE9MTF9J
Tik7CiAJCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnF1ZXVlLT5wcm9jX2xpc3QpOwogCQl9
CisJCWVsc2UKKwkJCS8vIDJLIGJ1ZmZlciBpcyBlbm91Z2ggZm9yIGFib3V0IDEwIHNlYyB1
bmRlciBub3JtYWwgb3BlcmF0aW9ucywgaGVyZS4KKwkJCXByaW50aygicHNhdXg6IGJ1ZmZl
ciBvdmVyZmxvdywgYnl0ZSBkcm9wcGVkLlxuIik7CiAJfQogI2VuZGlmCiB9CkBAIC00NjUs
NiArNDczLDExIEBACiAJCQllbHNlCiAJCQkJaGFuZGxlX2tleWJvYXJkX2V2ZW50KHNjYW5j
b2RlKTsKIAkJfQorCQllbHNlCisJCQkvLyBGaXhtZTogSWdub3JpbmcgYnl0ZXMgd2lsbCBk
ZS1zeW5jIG1vdXNlIHByb3RvY29sLgorCQkJcHJpbnRrKCJwY19rZXliOiAlcyBlcnJvciAo
MHglMDJ4KSwgYnl0ZSBpZ25vcmVkKCUwMngpLlxuIiwKKwkJCShzdGF0dXMgJiBLQkRfU1RB
VF9NT1VTRV9PQkYpPyJtb3VzZSI6ImtiZCIsc3RhdHVzLHNjYW5jb2RlKTsKKwogCiAJCXN0
YXR1cyA9IGtiZF9yZWFkX3N0YXR1cygpOwogCX0K
--------------56546803550E8F9B818437ED--

