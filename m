Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSF2Wv7>; Sat, 29 Jun 2002 18:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSF2Wv6>; Sat, 29 Jun 2002 18:51:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45814 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S314403AbSF2Wvx>; Sat, 29 Jun 2002 18:51:53 -0400
Date: Sun, 30 Jun 2002 00:53:57 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: <dalecki@evision-ventures.com>, <alex@ssi.bg>, <zwane@linux.realnet.co.sz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 95
In-Reply-To: <20020630001214.GF25118@ppc.vc.cvut.cz>
Message-ID: <Pine.SOL.4.30.0206300024030.12467-300000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1025391237=:12467"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1025391237=:12467
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi Petr!

On Sun, 30 Jun 2002, Petr Vandrovec wrote:

> Hi,
>   I know that IDE95 is broken when it comes to IDE, but... not only
> that. Patch below does:
>
> (1) ide-taskfile.c: ide_do_drive_cmd(..., ide_preempt) holds channel
>     lock. Do not reacquire. NMI watchdog triggered by just booting
>     computer with IDE cdrom.

Mentioned in 95 changelog.
Already fixed in my tree, but thanks anyway.

> (2) ide.c: if we clear BUSY, use goto ... instead of break. There is
>     set_bit(IDE_BUSY, ch->active); below loop. Channel stopped by 'hdparm
>     -I /dev/hdd': it uses ide_raw_taskfile() which sets REQ_SPECIAL.
>     But ide-cd:ide_cdrom_do_request() does not handle REQ_SPECIAL,
>     it returns ide_stopped immediately. And ide:do_request() does not
>     cope with ide_stopped + empty queue correctly.

This set_bit(IDE_BUSY, ch->active); introduced in 94 is basically wrong,
also already fixed in my tree ;-)

> (3) unfixed: hdparm -I returns garbage on CDROM: REQ_SPECIAL command
>     on CD drive returns success without trying to execute it in
>     current driver. I think that ide-cd should handle direct interface
>     to its registers properly.
>

Have to look at it, thanks for info.

Attached patch is next ide-clean patch pre-patch ;), just not to duplicate
efforts. Changelog is also included. As always use with care, standard
disclaimer apply.

And final note: I think that previous locking (2.4.x but ch->lock instead
of global io_request_lock) was well tuned and almost 100% correct.
Recent changes just made it worse (sorry Martin :) ).
Now even if we add unmasking IRQs with disabling currently handled IRQ, it
will be less friendlier to shared PCI interrupts (especially in PIO it
will be overkill to disable shared IRQ for handling PIO intr!),
so I want to revert to previous scheme...

Greets.

> Patch is for 2.5.24+IDE94+IDE95.
> 					Best regards,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
>
>
>
>
> diff -urdN linux/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
> --- linux/drivers/ide/ide-taskfile.c	Sun Jun 30 00:54:05 2002
> +++ linux/drivers/ide/ide-taskfile.c	Sat Jun 29 12:54:48 2002
> @@ -209,10 +209,16 @@
>  	rq->errors = 0;
>  	rq->rq_status = RQ_ACTIVE;
>  	rq->rq_dev = mk_kdev(major,(drive->select.b.unit)<<PARTN_BITS);
> -	if (action == ide_wait)
> +	if (action == ide_wait) {
>  		rq->waiting = &wait;
> -
> -	spin_lock_irqsave(drive->channel->lock, flags);
> +		spin_lock_irqsave(drive->channel->lock, flags);
> +	} else if (action == ide_preempt) {
> +		if (0 /* SMP... !spin_is_locked(drive->channel->lock) */) {
> +			BUG();
> +		}
> +	} else {
> +		BUG();

This is not completly correct, you forgot about ide_end (default action,
broken anyway, please read patch info).

> +	}
>
>  	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
>  		if (action == ide_preempt)
> @@ -227,9 +233,9 @@
>
>  	do_ide_request(q);
>
> -	spin_unlock_irqrestore(drive->channel->lock, flags);
> -
>  	if (action == ide_wait) {
> +		spin_unlock_irqrestore(drive->channel->lock, flags);
> +
>  		wait_for_completion(&wait);	/* wait for it to be serviced */
>  		return rq->errors ? -EIO : 0;	/* return -EIO if errors */
>  	}
> diff -urdN linux/drivers/ide/ide.c linux/drivers/ide/ide.c
> --- linux/drivers/ide/ide.c	Sun Jun 30 00:54:05 2002
> +++ linux/drivers/ide/ide.c	Sat Jun 29 23:45:47 2002
> @@ -864,7 +864,7 @@
>  			if (!ata_can_queue(drive)) {
>  				if (!ata_pending_commands(drive))
>  					clear_bit(IDE_BUSY, ch->active);
> -				break;
> +				goto dontsetbusy;
>  			}
>
>  			drive->sleep = 0;
> @@ -889,7 +889,7 @@
>  				if (!ata_pending_commands(drive))
>  					clear_bit(IDE_BUSY, ch->active);
>  				drive->rq = NULL;
> -				break;
> +				goto dontsetbusy;
>  			}
>
>  			/* If there are queued commands, we can't start a
> @@ -906,6 +906,7 @@
>  		/* make sure the BUSY bit is set */
>  		/* FIXME: perhaps there is some place where we miss to set it? */
>  		set_bit(IDE_BUSY, ch->active);
> +dontsetbusy:;
>  	}
>  }
>
>

---559023410-1804928587-1025391237=:12467
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ide-96-pre.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0206300053570.12467@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="ide-96-pre.diff"

ZGlmZiAtdXIgbGludXgtMi41LjI0L2RyaXZlcnMvaWRlL2lkZS1kaXNrLmMg
bGludXgvZHJpdmVycy9pZGUvaWRlLWRpc2suYw0KLS0tIGxpbnV4LTIuNS4y
NC9kcml2ZXJzL2lkZS9pZGUtZGlzay5jCVRodSBKdW4gMjcgMTM6MzQ6NDIg
MjAwMg0KKysrIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS1kaXNrLmMJRnJpIEp1
biAyOCAyMjo1Mzo1MyAyMDAyDQpAQCAtMjc5LDE0ICsyNzksMTYgQEANCiAJ
CXJxLT5iaW8gPSBOVUxMOw0KIAkJcmV0ID0gaWRlX3N0b3BwZWQ7DQogCX0g
ZWxzZSBpZiAoIW9rKSB7DQotCQkvKiBubyBkYXRhIHlldCwgc28gd2FpdCBm
b3IgYW5vdGhlciBpbnRlcnJ1cHQgKi8NCi0JCS8qIEZJWE1FOiAgLS1iem9s
bmllciAqLw0KLQkJaWYgKCFjaC0+aGFuZGxlcikNCi0JCQlhdGFfc2V0X2hh
bmRsZXIoZHJpdmUsIHRhc2tfbXVsb3V0X2ludHIsIFdBSVRfQ01ELCBOVUxM
KTsNCisJCS8qIG5vdCByZWFkeSB5ZXQsIHNvIHdhaXQgZm9yIG5leHQgSVJR
ICovDQorCQlhdGFfc2V0X2hhbmRsZXIoZHJpdmUsIHRhc2tfbXVsb3V0X2lu
dHIsIFdBSVRfQ01ELCBOVUxMKTsNCisNCiAJCXJldCA9IGlkZV9zdGFydGVk
Ow0KIAl9IGVsc2Ugew0KIAkJaW50IG1jb3VudCA9IGRyaXZlLT5tdWx0X2Nv
dW50Ow0KIA0KKwkJLyogcHJlcGFyZSBmb3IgbmV4dCBJUlEgKi8NCisJCWF0
YV9zZXRfaGFuZGxlcihkcml2ZSwgdGFza19tdWxvdXRfaW50ciwgV0FJVF9D
TUQsIE5VTEwpOw0KKw0KIAkJZG8gew0KIAkJCWNoYXIgKmJ1ZjsNCiAJCQlp
bnQgbnNlY3QgPSBycS0+Y3VycmVudF9ucl9zZWN0b3JzOw0KQEAgLTMxNCw2
ICszMTYsNyBAQA0KIAkJCQkJcnEtPmN1cnJlbnRfbnJfc2VjdG9ycyA9IGJp
b19pb3ZlYyhiaW8pLT5idl9sZW4gPj4gOTsNCiAJCQkJfQ0KIAkJCX0NCisJ
CQlycS0+ZXJyb3JzID0gMDsgLyogRklYTUU6IHdoeT8gIC0tYnpvbG5pZXIg
Ki8NCiANCiAJCQkvKg0KIAkJCSAqIE9rLCB3ZSdyZSBhbGwgc2V0dXAgZm9y
IHRoZSBpbnRlcnJ1cHQgcmUtZW50ZXJpbmcgdXMgb24gdGhlDQpAQCAtMzIz
LDEyICszMjYsNiBAQA0KIAkJCWJpb19rdW5tYXBfaXJxKGJ1ZiwgJmZsYWdz
KTsNCiAJCX0gd2hpbGUgKG1jb3VudCk7DQogDQotCQlycS0+ZXJyb3JzID0g
MDsNCi0NCi0JCS8qIEZJWE1FOiAgLS1iem9sbmllciAqLw0KLQkJaWYgKCFj
aC0+aGFuZGxlcikNCi0JCQlhdGFfc2V0X2hhbmRsZXIoZHJpdmUsIHRhc2tf
bXVsb3V0X2ludHIsIFdBSVRfQ01ELCBOVUxMKTsNCi0NCiAJCXJldCA9IGlk
ZV9zdGFydGVkOw0KIAl9DQogDQpAQCAtNTI2LDYgKzUyMyw3IEBADQogCQlw
cmludGsoImJ1ZmZlcj0lcFxuIiwgcnEtPmJ1ZmZlcik7DQogI2VuZGlmDQog
CX0NCisJcnEtPnNwZWNpYWwgPSBhcjsNCiANCiAJLyoNCiAJICogQ2hhbm5l
bCBsb2NrIHNob3VsZCBiZSBoZWxkIG9uIGVudHJ5Lg0KQEAgLTU1MiwyOCAr
NTUwLDI1IEBADQogCS8qIEZJWE1FOiB0aGlzIGlzIGFjdHVhbGx5IGRpc3Rp
bmd1c2hpbmcgYmV0d2VlbiBQSU8gYW5kIERNQSByZXF1ZXN0cy4NCiAJICov
DQogCWlmIChhci0+WFhYX2hhbmRsZXIpIHsNCisJCWlmIChhci0+Y29tbWFu
ZF90eXBlID09IElERV9EUklWRV9UQVNLX0lOIHx8DQorCQkgICAgYXItPmNv
bW1hbmRfdHlwZSA9PSBJREVfRFJJVkVfVEFTS19OT19EQVRBKSB7DQogDQot
CQlhdGFfc2V0X2hhbmRsZXIoZHJpdmUsIGFyLT5YWFhfaGFuZGxlciwgV0FJ
VF9DTUQsIE5VTEwpOw0KLQkJT1VUX0JZVEUoY21kLCBJREVfQ09NTUFORF9S
RUcpOw0KKwkJCWF0YV9zZXRfaGFuZGxlcihkcml2ZSwgYXItPlhYWF9oYW5k
bGVyLCBXQUlUX0NNRCwgTlVMTCk7DQorCQkJT1VUX0JZVEUoY21kLCBJREVf
Q09NTUFORF9SRUcpOw0KKw0KKwkJCXJldHVybiBpZGVfc3RhcnRlZDsNCisJ
CX0NCiANCiAJCS8qIEZJWE1FOiBXYXJuaW5nIGNoZWNrIGZvciByYWNlIGJl
dHdlZW4gaGFuZGxlciBhbmQgcHJlaGFuZGxlcg0KIAkJICogZm9yIHdyaXRp
bmcgZmlyc3QgYmxvY2sgb2YgZGF0YS4gIGhvd2V2ZXIgc2luY2Ugd2UgYXJl
IHdlbGwNCiAJCSAqIGluc2lkZSB0aGUgYm91bmRhcmllcyBvZiB0aGUgc2Vl
aywgd2Ugc2hvdWxkIGJlIG9rYXkuDQotCQkgKg0KLQkJICogRklYTUU6IFJl
cGxhY2UgdGhlIHN3aXRjaCBieSB1c2luZyBhIHByb3BlciBjb21tYW5kX3R5
cGUuDQorCQkgKiBGSVhNRTogc2hvdWxkIGJlIGZpeGVkICAtLWJ6b2xuaWVy
DQogCQkgKi8NCi0NCi0JCWlmIChjbWQgPT0gQ0ZBX1dSSVRFX1NFQ1RfV09f
RVJBU0UgfHwNCi0JCSAgICBjbWQgPT0gV0lOX1dSSVRFIHx8DQotCQkgICAg
Y21kID09IFdJTl9XUklURV9FWFQgfHwNCi0JCSAgICBjbWQgPT0gV0lOX1dS
SVRFX1ZFUklGWSB8fA0KLQkJICAgIGNtZCA9PSBXSU5fV1JJVEVfQlVGRkVS
IHx8DQotCQkgICAgY21kID09IFdJTl9ET1dOTE9BRF9NSUNST0NPREUgfHwN
Ci0JCSAgICBjbWQgPT0gQ0ZBX1dSSVRFX01VTFRJX1dPX0VSQVNFIHx8DQot
CQkgICAgY21kID09IFdJTl9NVUxUV1JJVEUgfHwNCi0JCSAgICBjbWQgPT0g
V0lOX01VTFRXUklURV9FWFQpIHsNCisJCWlmIChhci0+Y29tbWFuZF90eXBl
ID09IElERV9EUklWRV9UQVNLX1JBV19XUklURSkgew0KIAkJCWlkZV9zdGFy
dHN0b3BfdCBzdGFydHN0b3A7DQogDQorCQkJT1VUX0JZVEUoY21kLCBJREVf
Q09NTUFORF9SRUcpOw0KKw0KIAkJCWlmIChhdGFfc3RhdHVzX3BvbGwoZHJp
dmUsIERBVEFfUkVBRFksIGRyaXZlLT5iYWRfd3N0YXQsDQogCQkJCQkJV0FJ
VF9EUlEsIHJxLCAmc3RhcnRzdG9wKSkgew0KIAkJCQlwcmludGsoS0VSTl9F
UlIgIiVzOiBubyBEUlEgYWZ0ZXIgaXNzdWluZyAlc1xuIiwNCkBAIC01OTEs
NyArNTg2LDEwIEBADQogCQkJCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCQkJ
CWNoYXIgKmJ1ZiA9IGlkZV9tYXBfcnEocnEsICZmbGFncyk7DQogDQorCQkJ
CWF0YV9zZXRfaGFuZGxlcihkcml2ZSwgYXItPlhYWF9oYW5kbGVyLCBXQUlU
X0NNRCwgTlVMTCk7DQorDQogCQkJCS8qIEZvciBXcml0ZV9zZWN0b3JzIHdl
IG5lZWQgdG8gc3R1ZmYgdGhlIGZpcnN0IHNlY3RvciAqLw0KKwkJCQkvKiBG
SVhNRTogd2hhdCBpZiAhcnEtPmN1cnJlbnRfbnJfc2VjdG9ycyAgLS1iem9s
bmllciAqLw0KIAkJCQlhdGFfd3JpdGUoZHJpdmUsIGJ1ZiwgU0VDVE9SX1dP
UkRTKTsNCiANCiAJCQkJcnEtPmN1cnJlbnRfbnJfc2VjdG9ycy0tOw0KQEAg
LTYyMSw2ICs2MTksNyBAQA0KIAkJCQkJcHJpbnRrKEtFUk5fRVJSICJESVNB
U1RFUiBXQUlUSU5HIFRPIEhBUFBFTiFcbiIpOw0KIAkJCQl9DQogDQorCQkJ
CS8qIHdpbGwgc2V0IGhhbmRsZXIgZm9yIHVzICovDQogCQkJCXJldHVybiBh
ci0+WFhYX2hhbmRsZXIoZHJpdmUsIHJxKTsNCiAJCQl9DQogCQl9DQpAQCAt
NjMyLDYgKzYzMSw3IEBADQogCQkgKiBGSVhNRTogSGFuZGxlIHRoZSBhbHRl
cm5hdGVpdmVzIGJ5IGEgY29tbWFuZCB0eXBlLg0KIAkJICovDQogDQorCQkv
KiBGSVhNRTogaWRlX3N0YXJ0ZWQ/ICAtLWJ6b2xuaWVyICovDQogCQlpZiAo
IWRyaXZlLT51c2luZ19kbWEpDQogCQkJcmV0dXJuIGlkZV9zdGFydGVkOw0K
IA0KQEAgLTY1Niw2ICs2NTYsNyBAQA0KIAkJfQ0KIAl9DQogDQorCS8qIG5v
dCByZWFjaGVkICovDQogCXJldHVybiBpZGVfc3RhcnRlZDsNCiB9DQogDQpk
aWZmIC11ciBsaW51eC0yLjUuMjQvZHJpdmVycy9pZGUvaWRlLXRhc2tmaWxl
LmMgaWRlL2lkZS10YXNrZmlsZS5jDQotLS0gbGludXgtMi41LjI0L2RyaXZl
cnMvaWRlL2lkZS10YXNrZmlsZS5jCVRodSBKdW4gMjcgMTM6MzQ6NDIgMjAw
Mg0KKysrIGlkZS9pZGUtdGFza2ZpbGUuYwlGcmkgSnVuIDI4IDIzOjA2OjI3
IDIwMDINCkBAIC0yMDksMjcgKzIwOSwyMiBAQA0KIAlycS0+ZXJyb3JzID0g
MDsNCiAJcnEtPnJxX3N0YXR1cyA9IFJRX0FDVElWRTsNCiAJcnEtPnJxX2Rl
diA9IG1rX2tkZXYobWFqb3IsKGRyaXZlLT5zZWxlY3QuYi51bml0KTw8UEFS
VE5fQklUUyk7DQotCWlmIChhY3Rpb24gPT0gaWRlX3dhaXQpDQorCWlmIChh
Y3Rpb24gPT0gaWRlX3dhaXQpIHsNCiAJCXJxLT53YWl0aW5nID0gJndhaXQ7
DQorCQlzcGluX2xvY2tfaXJxc2F2ZShkcml2ZS0+Y2hhbm5lbC0+bG9jaywg
ZmxhZ3MpOw0KKwl9DQogDQotCXNwaW5fbG9ja19pcnFzYXZlKGRyaXZlLT5j
aGFubmVsLT5sb2NrLCBmbGFncyk7DQorCWlmIChhY3Rpb24gPT0gaWRlX3By
ZWVtcHQpDQorCQlkcml2ZS0+cnEgPSBOVUxMOw0KKwllbHNlIGlmICghYmxr
X3F1ZXVlX2VtcHR5KCZkcml2ZS0+cXVldWUpKQ0KKwkJcXVldWVfaGVhZCA9
IHF1ZXVlX2hlYWQtPnByZXY7CS8qIGlkZV9lbmQgYW5kIGlkZV93YWl0ICov
DQogDQotCWlmIChibGtfcXVldWVfZW1wdHkoJmRyaXZlLT5xdWV1ZSkgfHwg
YWN0aW9uID09IGlkZV9wcmVlbXB0KSB7DQotCQlpZiAoYWN0aW9uID09IGlk
ZV9wcmVlbXB0KQ0KLQkJCWRyaXZlLT5ycSA9IE5VTEw7DQotCX0gZWxzZSB7
DQotCQlpZiAoYWN0aW9uID09IGlkZV93YWl0KQ0KLQkJCXF1ZXVlX2hlYWQg
PSBxdWV1ZV9oZWFkLT5wcmV2Ow0KLQkJZWxzZQ0KLQkJCXF1ZXVlX2hlYWQg
PSBxdWV1ZV9oZWFkLT5uZXh0Ow0KLQl9DQogCXEtPmVsZXZhdG9yLmVsZXZh
dG9yX2FkZF9yZXFfZm4ocSwgcnEsIHF1ZXVlX2hlYWQpOw0KIA0KIAlkb19p
ZGVfcmVxdWVzdChxKTsNCiANCi0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZShk
cml2ZS0+Y2hhbm5lbC0+bG9jaywgZmxhZ3MpOw0KLQ0KIAlpZiAoYWN0aW9u
ID09IGlkZV93YWl0KSB7DQorCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKGRy
aXZlLT5jaGFubmVsLT5sb2NrLCBmbGFncyk7DQogCQl3YWl0X2Zvcl9jb21w
bGV0aW9uKCZ3YWl0KTsJLyogd2FpdCBmb3IgaXQgdG8gYmUgc2VydmljZWQg
Ki8NCiAJCXJldHVybiBycS0+ZXJyb3JzID8gLUVJTyA6IDA7CS8qIHJldHVy
biAtRUlPIGlmIGVycm9ycyAqLw0KIAl9DQpkaWZmIC11ciBsaW51eC0yLjUu
MjQvZHJpdmVycy9pZGUvaWRlLmMgbGludXgvZHJpdmVycy9pZGUvaWRlLmMN
Ci0tLSBsaW51eC0yLjUuMjQvZHJpdmVycy9pZGUvaWRlLmMJVGh1IEp1biAy
NyAxMzozNDo0MiAyMDAyDQorKysgbGludXgvZHJpdmVycy9pZGUvaWRlLmMJ
RnJpIEp1biAyOCAyMzo1NToyOCAyMDAyDQpAQCAtMTYxLDYgKzE2MSw3IEBA
DQogew0KIAlzdHJ1Y3QgYXRhX2NoYW5uZWwgKmNoID0gZHJpdmUtPmNoYW5u
ZWw7DQogDQorCS8qIEZJWE1FOiBjaGFuZ2UgaXQgbGF0ZXIgdG8gQlVHX09O
KGNoLT5oYW5kbGVyKSAgLS1iem9sbmllciAqLw0KIAlpZiAoY2gtPmhhbmRs
ZXIpDQogCQlwcmludGsoIiVzOiAlczogaGFuZGxlciBub3QgbnVsbDsgb2xk
PSVwLCBuZXc9JXAsIGZyb20gJXBcbiIsDQogCQkJZHJpdmUtPm5hbWUsIF9f
RlVOQ1RJT05fXywgY2gtPmhhbmRsZXIsIGhhbmRsZXIsIF9fYnVpbHRpbl9y
ZXR1cm5fYWRkcmVzcygwKSk7DQpAQCAtMTc3LDQzICsxNzgsMjkgQEANCiBz
dGF0aWMgdm9pZCBjaGVja19jcmNfZXJyb3JzKHN0cnVjdCBhdGFfZGV2aWNl
ICpkcml2ZSkNCiB7DQogCWlmICghZHJpdmUtPnVzaW5nX2RtYSkNCi0JICAg
IHJldHVybjsNCisJCXJldHVybjsNCiANCiAJLyogY2hlY2sgdGhlIERNQSBj
cmMgY291bnQgKi8NCiAJaWYgKGRyaXZlLT5jcmNfY291bnQpIHsNCiAJCXVk
bWFfZW5hYmxlKGRyaXZlLCAwLCAwKTsNCiAJCWlmIChkcml2ZS0+Y2hhbm5l
bC0+c3BlZWRwcm9jKSB7DQotCQkJdTggcGlvID0gWEZFUl9QSU9fNDsNCisJ
CQl1OCBtb2RlID0gZHJpdmUtPmN1cnJlbnRfc3BlZWQ7DQogCQkJZHJpdmUt
PmNyY19jb3VudCA9IDA7DQogDQotCQkJc3dpdGNoIChkcml2ZS0+Y3VycmVu
dF9zcGVlZCkgew0KLQkJCWNhc2UgWEZFUl9VRE1BXzc6IHBpbyA9IFhGRVJf
VURNQV82Ow0KLQkJCQlicmVhazsNCi0JCQljYXNlIFhGRVJfVURNQV82OiBw
aW8gPSBYRkVSX1VETUFfNTsNCi0JCQkJYnJlYWs7DQotCQkJY2FzZSBYRkVS
X1VETUFfNTogcGlvID0gWEZFUl9VRE1BXzQ7DQotCQkJCWJyZWFrOw0KLQkJ
CWNhc2UgWEZFUl9VRE1BXzQ6IHBpbyA9IFhGRVJfVURNQV8zOw0KLQkJCQli
cmVhazsNCi0JCQljYXNlIFhGRVJfVURNQV8zOiBwaW8gPSBYRkVSX1VETUFf
MjsNCi0JCQkJYnJlYWs7DQotCQkJY2FzZSBYRkVSX1VETUFfMjogcGlvID0g
WEZFUl9VRE1BXzE7DQotCQkJCWJyZWFrOw0KLQkJCWNhc2UgWEZFUl9VRE1B
XzE6IHBpbyA9IFhGRVJfVURNQV8wOw0KLQkJCQlicmVhazsNCisJCQlpZiAo
bW9kZSA+IFhGRVJfVURNQV8wKQ0KKwkJCQltb2RlLS07DQorCQkJZWxzZQ0K
IAkJCS8qDQogCQkJICogT09QUyB3ZSBkbyBub3QgZ290byBub24gVWx0cmEg
RE1BIG1vZGVzDQogCQkJICogd2l0aG91dCBpQ1JDJ3MgYXZhaWxhYmxlIHdl
IGZvcmNlDQogCQkJICogdGhlIHN5c3RlbSB0byBQSU8gYW5kIG1ha2UgdGhl
IHVzZXINCiAJCQkgKiBpbnZva2UgdGhlIEFUQS0xIEFUQS0yIERNQSBtb2Rl
cy4NCiAJCQkgKi8NCi0JCQljYXNlIFhGRVJfVURNQV8wOg0KLQkJCWRlZmF1
bHQ6DQotCQkJCXBpbyA9IFhGRVJfUElPXzQ7DQotCQkJfQ0KLQkJICAgICAg
ICBkcml2ZS0+Y2hhbm5lbC0+c3BlZWRwcm9jKGRyaXZlLCBwaW8pOw0KKwkJ
CQltb2RlID0gWEZFUl9QSU9fNDsNCisNCisJCQlkcml2ZS0+Y2hhbm5lbC0+
c3BlZWRwcm9jKGRyaXZlLCBtb2RlKTsNCiAJCX0NCi0JCWlmIChkcml2ZS0+
Y3VycmVudF9zcGVlZCA+PSBYRkVSX1NXX0RNQV8wKQ0KKwkJaWYgKGRyaXZl
LT5jdXJyZW50X3NwZWVkID49IFhGRVJfVURNQV8wKQ0KIAkJCXVkbWFfZW5h
YmxlKGRyaXZlLCAxLCAxKTsNCiAJfSBlbHNlDQogCQl1ZG1hX2VuYWJsZShk
cml2ZSwgMCwgMSk7DQpAQCAtOTAxLDEyICs4ODgsMTIgQEANCiANCiAJCQlk
cml2ZS0+cnEgPSBycTsNCiANCi0JCQlpZGVfX3N0aSgpOwkvKiBhbGxvdyBv
dGhlciBJUlFzIHdoaWxlIHdlIHN0YXJ0IHRoaXMgcmVxdWVzdCAqLw0KKy8v
CQkJaWRlX19zdGkoKTsJLyogYWxsb3cgb3RoZXIgSVJRcyB3aGlsZSB3ZSBz
dGFydCB0aGlzIHJlcXVlc3QgKi8NCiAJCQkvKiBjb21tYW5kIHN0YXJ0ZWQs
IHdlIGFyZSBidXN5ICovDQogCQl9IHdoaWxlIChpZGVfc3RhcnRlZCAhPSBz
dGFydF9yZXF1ZXN0KGRyaXZlLCBycSkpOw0KIAkJLyogbWFrZSBzdXJlIHRo
ZSBCVVNZIGJpdCBpcyBzZXQgKi8NCiAJCS8qIEZJWE1FOiBwZXJoYXBzIHRo
ZXJlIGlzIHNvbWUgcGxhY2Ugd2hlcmUgd2UgbWlzcyB0byBzZXQgaXQ/ICov
DQotCQlzZXRfYml0KElERV9CVVNZLCBjaC0+YWN0aXZlKTsNCisvLwkJc2V0
X2JpdChJREVfQlVTWSwgY2gtPmFjdGl2ZSk7DQogCX0NCiB9DQogDQo=
---559023410-1804928587-1025391237=:12467
Content-Type: TEXT/plain; name="ide-96-pre.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0206300053571.12467@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="ide-96-pre.txt"

DQotIGZpeCBidWcgaW50cm9kdWNlZCBpbiBJREUgNjMgaW4gaWRlX2RvX2Ry
aXZlX2NtZCgpLCBpZiBhY3Rpb24gaXMgaWRlX2VuZA0KICByZXF1ZXN0IHNo
b3VsZCBiZSBhZGRlZCB0byBlbmQgb2YgcXVldWUgbm90IG5leHQgdG8gY3Vy
cmVudCByZXF1ZXN0LA0KICBmb3J0dW5hdGVseSBpdCBpcyB1c2VkIG9ubHkg
YnkgaWRlLXRhcGUgd2hpY2ggaXMgYnJva2VuIGFueXdheQ0KDQotIGZpeCBi
dWcgaW50cm9kdWNlZCBpbiBJREUgOTQgaW4gaWRlZGlza19kb19yZXF1ZXN0
KCksIHJlbW92YWwgb2YNCiAgcnEtPnNwZWNpYWwgPSBhcjsgcHJvYmFibHkg
bmVlZGVkIGJ5IFBNQUMgYW5kIFRDUQ0KDQotIGZpeCBidWcgaW50cm9kdWNl
ZCBpbiBJREUgOTQgaW4gZG9fcmVxdWVzdCgpLCBhbHdheXMgc2V0dGluZyBJ
REVfQlVTWQ0KICBiaXQgY291bGQgbGVhZCB0byBkZWFkbG9jaw0KDQotIGRp
c2FibGUgaWRlX19zdGkoKSBpbiBkb19yZXF1ZXN0KCksIGRvaW5nIF9fc3Rp
KCkgd2hpbGUgaG9sZGluZyBpcnFzYXZpbmcNCiAgc3BpbmxvY2sgaXMgbm90
IGdvb2QgaWRlYQ0KDQotIGluIGNoZWNrX2NyY19lcnJvcnMoKSBkbyBzdHJp
Y3QgY2hlY2tpbmcgZm9yIFVETUEgbW9kZXMNCg0KLSBjbGVhbiBkb3VibGUg
c2V0dGluZyBoYW5kbGVyL3RpbWVyIGhhY2sNCg0KLSBpbiBpZGVfZG9fZHJp
dmVfY21kKCkgaG9sZCBjaGFubmVsIGxvY2sgb25seSBpZiBhY3Rpb24gaXMg
aWRlX3dhaXQNCg0K
---559023410-1804928587-1025391237=:12467--
