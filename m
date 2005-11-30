Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbVK3TbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbVK3TbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbVK3TbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:31:04 -0500
Received: from fri.itea.ntnu.no ([129.241.7.60]:26603 "EHLO fri.itea.ntnu.no")
	by vger.kernel.org with ESMTP id S1751514AbVK3TbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:31:02 -0500
Subject: Re: [PATCH 2.6.14.2] Updated itmtouch kernel usb input driver (1/1)
From: Hans-Christian Egtvedt <hc@mivu.no>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <200511232101.33783.dtor_core@ameritech.net>
References: <1132764764.6394.14.camel@charlie.egtvedt.no>
	 <20051123165813.GA3201@ucw.cz> <200511232101.33783.dtor_core@ameritech.net>
Content-Type: multipart/mixed; boundary="=-5zDyK4G1G1mtaNuozK2Z"
Organization: MIVU Solutions
Date: Wed, 30 Nov 2005 20:31:00 +0100
Message-Id: <1133379060.5318.14.camel@charlie.egtvedt.no>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5zDyK4G1G1mtaNuozK2Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-11-23 at 21:01 -0500, Dmitry Torokhov wrote:
> On Wednesday 23 November 2005 11:58, Vojtech Pavlik wrote:
> > >  static int itmtouch_open(struct input_dev *input)
> > >  {
> > >       struct itmtouch_dev *itmtouch = input->private;
> > >  
> > > +     if (itmtouch->users++)
> > > +             return 0;
> > > +
> 
> Why are you adding this? input_open/close are serialized and called
> only once when needed.

I see I shiped my patch a bit hastly, this is dropped as discussed the
very first time I submitted this driver (Mars I think). I had totally
forgotten about this serializing.

> > >       itmtouch->readurb->dev = itmtouch->usbdev;
> > >  
> > >       if (usb_submit_urb(itmtouch->readurb, GFP_KERNEL))
> > > +     {
> > > +             itmtouch->users--;
> > >               return -EIO;
> > > +     }
> > >  
> 
> Brace should go on the same line with "if".

Typo, corrected.

> > > -     usb_to_input_id(udev, &itmtouch->inputdev.id);
> > > +     itmtouch->inputdev.id.bustype = BUS_USB;
> > > +     itmtouch->inputdev.id.vendor = udev->descriptor.idVendor;
> > > +     itmtouch->inputdev.id.product = udev->descriptor.idProduct;
> > > +     itmtouch->inputdev.id.version = udev->descriptor.bcdDevice;
> > >       itmtouch->inputdev.dev = &intf->dev;
> 
> Why are you replacing perfectly good code with incorrect one (endianess
> issues)?

This was already present but not syncronized with my local repository,
corrected.

> Plus you need to convert it to dynamic input_dev allocation for newer
> kernels. 

This is new for me, I will look into it.

I have also removed the nosync parameter since it was not welcome. I
can't reproduce the double click fault with my LG L1510SF screen with
the 2.6.14 kernel. So my guess is it is either a bug in some screens
(I've changed mine just a couple of weeks ago) or an old bug in the
kernel which has been solved.

Thanks for the feedback.

I've attached a patch to match all the comments. 

-- 
Hans-Christian Egtvedt <hc@mivu.no>
MIVU Solutions

--=-5zDyK4G1G1mtaNuozK2Z
Content-Disposition: attachment; filename=itmtouch-1.3.2-linux-2.6.14.2.patch
Content-Type: text/x-patch; name=itmtouch-1.3.2-linux-2.6.14.2.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIC91c3Ivc3JjL2xpbnV4LTIuNi4xNC4yL2RyaXZlcnMvdXNiL2lucHV0L2l0bXRvdWNoLmMJ
MjAwNS0xMS0yMyAxNjowMjo1NS4wMDAwMDAwMDAgKzAxMDANCisrKyBpdG10b3VjaC5jCTIwMDUt
MTEtMzAgMjA6MTg6NDguMDAwMDAwMDAwICswMTAwDQpAQCAtMjIsMTUgKzIyLDMyIEBADQogICog
ZHJpdmVyLiBDQyAtLSAyMDAzLzkvMjkNCiAgKg0KICAqIEhpc3RvcnkNCi0gKiAxLjAgJiAxLjEg
MjAwMyAoQ0MpIHZvanRlY2hAc3VzZS5jeg0KLSAqICAgT3JpZ2luYWwgdmVyc2lvbiBmb3IgMi40
Lngga2VybmVscw0KKyAqIDEuMCAmIDEuMSAgICAyMDAzIChDQykgdm9qdGVjaEBzdXNlLmN6DQor
ICogICAtIE9yaWdpbmFsIHZlcnNpb24gZm9yIDIuNC54IGtlcm5lbHMNCiAgKg0KLSAqIDEuMiAw
Mi8wMy8yMDA1IChIQ0UpIGhjQG1pdnUubm8NCi0gKiAgIENvbXBsZXRlIHJld3JpdGUgdG8gc3Vw
cG9ydCBMaW51eCAyLjYuMTAsIHRoYW5rcyB0byBtdG91Y2h1c2IuYyBmb3IgaGludHMuDQotICog
ICBVbmZvcnR1bmF0ZWx5IG5vIGNhbGlicmF0aW9uIHN1cHBvcnQgYXQgdGhpcyB0aW1lLg0KKyAq
IDEuMiAgICAwMi8wMy8yMDA1IChIQ0UpIGhjQG1pdnUubm8NCisgKiAgIC0gQ29tcGxldGUgcmV3
cml0ZSB0byBzdXBwb3J0IExpbnV4IDIuNi4xMCwgdGhhbmtzIHRvIG10b3VjaHVzYi5jIGZvciBo
aW50cy4NCisgKiAgIC0gVW5mb3J0dW5hdGVseSBubyBjYWxpYnJhdGlvbiBzdXBwb3J0IGF0IHRo
aXMgdGltZS4NCiAgKg0KICAqIDEuMi4xICAwOS8wMy8yMDA1IChIQ0UpIGhjQG1pdnUubm8NCi0g
KiAgIENvZGUgY2xlYW51cCBhbmQgYWRqdXN0aW5nIHN5bnRheCB0byBzdGFydCBtYXRjaGluZyBr
ZXJuZWwgc3RhbmRhcmRzDQorICogICAtIENvZGUgY2xlYW51cCBhbmQgYWRqdXN0aW5nIHN5bnRh
eCB0byBzdGFydCBtYXRjaGluZyBrZXJuZWwgc3RhbmRhcmRzDQorICoNCisgKiAxLjIuMiAgMTAv
MDMvMjAwNSAoSENFKSBoY0BtaXZ1Lm5vDQorICogICAtIENvZGUgY2xlYW51cA0KKyAqDQorICog
MS4zLjAgIDE3LzAzLzIwMDUgKEhDRSkgaGNAbWl2dS5ubw0KKyAqICAgLSBBZGRlZCBwYXJhbWV0
ZXIgZm9yIHN3YXBwaW5nIFgtIGFuZCBZLWF4aXMgKHN3YXB4eSkuDQorICogICAtIEdlbmVyYWwg
Y29kZSBjbGVhbnVwDQorICoNCisgKiAxLjMuMSAgMjMvMTEvMjAwNSAoSENFKSBoY0BtaXZ1Lm5v
DQorICogICAtIEFkZGVkIHBhcmFtZXRlciBub3N5bmMgZm9yIGRpc2FibGluZyBpbnB1dF9zeW5j
LiBQYW5lbCBpcyB1bnVzYWJsZQ0KKyAqICAgICB3aXRob3V0IHRoaXMsIGJ1dCBwZW9wbGUgc2hv
dWxkIGJlIGFibGUgdG8gY2hvc2UuDQorICogICAtIEFkZGVkIHN3YXB4IGFuZCBzd2FweSB0byBt
YWtlIGl0IGVhc2llciB0byBhZG9wdCB0byBYIGRyaXZlcnMuDQorICoNCisgKiAxLjMuMiAgMzAv
MTEvMjAwNSAoSENFKSBoY0BtaXZ1Lm5vDQorICogICAtIFJlbW92ZWQgbm9zeW5jIHBhcmFtZXRl
ciBmb3Igbm93Lg0KKyAqICAgLSBBZGRlZCB1c2Ugb2YgdXNiX3RvX2lucHV0X2lkKCkuDQorICog
ICAtIENvZGUgY2xlYW51cC4NCiAgKg0KICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCiANCkBAIC01
OCw3ICs3NSw3IEBADQogI2RlZmluZSBVU0JfUFJPRFVDVF9JRF9UT1VDSFBBTkVMCTB4ZjllOQ0K
IA0KICNkZWZpbmUgRFJJVkVSX0FVVEhPUiAiSGFucy1DaHJpc3RpYW4gRWd0dmVkdCA8aGNAbWl2
dS5ubz4iDQotI2RlZmluZSBEUklWRVJfVkVSU0lPTiAidjEuMi4xIg0KKyNkZWZpbmUgRFJJVkVS
X1ZFUlNJT04gInYxLjMuMiINCiAjZGVmaW5lIERSSVZFUl9ERVNDICJVU0IgSVRNIEluYyBUb3Vj
aCBQYW5lbCBEcml2ZXIiDQogI2RlZmluZSBEUklWRVJfTElDRU5TRSAiR1BMIg0KIA0KQEAgLTY2
LDE0ICs4MywyMiBAQA0KIE1PRFVMRV9ERVNDUklQVElPTiggRFJJVkVSX0RFU0MgKTsNCiBNT0RV
TEVfTElDRU5TRSggRFJJVkVSX0xJQ0VOU0UgKTsNCiANCitzdGF0aWMgaW50IHN3YXB4eSwgc3dh
cHgsIHN3YXB5Ow0KKw0KK21vZHVsZV9wYXJhbShzd2FweHksIGludCwgU19JUlVTUiB8IFNfSVdV
U1IgfCBTX0lSR1JQIHwgU19JUk9USCk7DQorTU9EVUxFX1BBUk1fREVTQyhzd2FweHksICJJZiBz
ZXQgdGhlIFgtIGFuZCBZLWF4aXMgYXJlIHN3YXBwZWQuIik7DQorbW9kdWxlX3BhcmFtKHN3YXB4
LCBpbnQsIFNfSVJVU1IgfCBTX0lXVVNSIHwgU19JUkdSUCB8IFNfSVJPVEgpOw0KK01PRFVMRV9Q
QVJNX0RFU0Moc3dhcHgsICJJZiBzZXQgdGhlIFgtYXhpcyBpcyByZXZlcnNlZCBpbiBkaXJlY3Rp
b24uIik7DQorbW9kdWxlX3BhcmFtKHN3YXB5LCBpbnQsIFNfSVJVU1IgfCBTX0lXVVNSIHwgU19J
UkdSUCB8IFNfSVJPVEgpOw0KK01PRFVMRV9QQVJNX0RFU0Moc3dhcHksICJJZiBzZXQgdGhlIFkt
YXhpcyBpcyByZXZlcnNlZCBpbiBkaXJlY3Rpb24uIik7DQorDQogc3RydWN0IGl0bXRvdWNoX2Rl
diB7DQogCXN0cnVjdCB1c2JfZGV2aWNlCSp1c2JkZXY7IC8qIHVzYiBkZXZpY2UgKi8NCiAJc3Ry
dWN0IGlucHV0X2RldglpbnB1dGRldjsgLyogaW5wdXQgZGV2aWNlICovDQogCXN0cnVjdCB1cmIJ
CSpyZWFkdXJiOyAvKiB1cmIgKi8NCiAJY2hhcgkJCXJidWZbSVRNX0JVRlNJWkVdOyAvKiBkYXRh
ICovDQotCWludAkJCXVzZXJzOw0KLQljaGFyIG5hbWVbMTI4XTsNCi0JY2hhciBwaHlzWzY0XTsN
CisJY2hhcgkJCW5hbWVbMTI4XTsNCisJY2hhcgkJCXBoeXNbNjRdOw0KIH07DQogDQogc3RhdGlj
IHN0cnVjdCB1c2JfZGV2aWNlX2lkIGl0bXRvdWNoX2lkcyBbXSA9IHsNCkBAIC04MywxNyArMTA4
LDE4IEBADQogDQogc3RhdGljIHZvaWQgaXRtdG91Y2hfaXJxKHN0cnVjdCB1cmIgKnVyYiwgc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpDQogew0KLQlzdHJ1Y3QgaXRtdG91Y2hfZGV2ICogaXRtdG91Y2gg
PSB1cmItPmNvbnRleHQ7DQotCXVuc2lnbmVkIGNoYXIgKmRhdGEgPSB1cmItPnRyYW5zZmVyX2J1
ZmZlcjsNCisJc3RydWN0IGl0bXRvdWNoX2RldiAqaXRtdG91Y2ggPSB1cmItPmNvbnRleHQ7DQog
CXN0cnVjdCBpbnB1dF9kZXYgKmRldiA9ICZpdG10b3VjaC0+aW5wdXRkZXY7DQorCXVuc2lnbmVk
IGludCB4LCB5LCBhYnMsIGJ1dHRvbjsNCiAJaW50IHJldHZhbDsNCisJdTggKmRhdGE7DQogDQog
CXN3aXRjaCAodXJiLT5zdGF0dXMpIHsNCiAJY2FzZSAwOg0KIAkJLyogc3VjY2VzcyAqLw0KIAkJ
YnJlYWs7DQogCWNhc2UgLUVUSU1FRE9VVDoNCi0JCS8qIHRoaXMgdXJiIGlzIHRpbWluZyBvdXQg
Ki8NCisJCS8qIHRoaXMgdXJiIGlzIHRpbWluZyBvdXQsIGRldmljZSB1bnBsdWdnZWQ/ICovDQog
CQlkYmcoIiVzIC0gdXJiIHRpbWVkIG91dCAtIHdhcyB0aGUgZGV2aWNlIHVucGx1Z2dlZD8iLA0K
IAkJICAgIF9fRlVOQ1RJT05fXyk7DQogCQlyZXR1cm47DQpAQCAtMTEwLDIwICsxMzYsNDQgQEAN
CiAJCWdvdG8gZXhpdDsNCiAJfQ0KIA0KKwlkYXRhID0gKHU4ICopKHVyYi0+dHJhbnNmZXJfYnVm
ZmVyKTsNCisNCisJaWYgKHN3YXB4KQ0KKwkJeCA9IChkYXRhWzFdICYgMHgxRikgPDwgNyB8IChk
YXRhWzRdICYgMHg3Rik7DQorCWVsc2UNCisJCXggPSA0MDk2IC0gKChkYXRhWzFdICYgMHgxRikg
PDwgNyB8IChkYXRhWzRdICYgMHg3RikpOw0KKw0KKwlpZiAoc3dhcHkpDQorCQl5ID0gNDA5NiAt
ICgoZGF0YVswXSAmIDB4MUYpIDw8IDcgfCAoZGF0YVszXSAmIDB4N0YpKTsNCisJZWxzZQ0KKwkJ
eSA9IChkYXRhWzBdICYgMHgxRikgPDwgNyB8IChkYXRhWzNdICYgMHg3Rik7DQorDQorCWFicyA9
IChkYXRhWzJdICYgMHgxKSA8PCA3IHwgKGRhdGFbNV0gJiAweDdGKTsNCisNCisJLyogVmFsdWUg
aXMgMHg4MCB3aGVuIHByZXNzZWQgYW5kIDB4QTAgd2hlbiByZWxlYXNlZCAqLw0KKwlidXR0b24g
PSAhKGRhdGFbN10gJiAweDIwKTsNCisNCiAJaW5wdXRfcmVncyhkZXYsIHJlZ3MpOw0KIA0KLQkv
KiBpZiBwcmVzc3VyZSBoYXMgYmVlbiByZWxlYXNlZCwgdGhlbiBkb24ndCByZXBvcnQgWC9ZICov
DQotCWlmIChkYXRhWzddICYgMHgyMCkgew0KLQkJaW5wdXRfcmVwb3J0X2FicyhkZXYsIEFCU19Y
LCAoZGF0YVswXSAmIDB4MUYpIDw8IDcgfCAoZGF0YVszXSAmIDB4N0YpKTsNCi0JCWlucHV0X3Jl
cG9ydF9hYnMoZGV2LCBBQlNfWSwgKGRhdGFbMV0gJiAweDFGKSA8PCA3IHwgKGRhdGFbNF0gJiAw
eDdGKSk7DQorCWlmIChidXR0b24pIHsNCisJCWlmIChzd2FweHkpIHsNCisJCQlpbnB1dF9yZXBv
cnRfYWJzKGRldiwgQUJTX1gsIHkpOw0KKwkJCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBBQlNfWSwg
eCk7DQorCQl9DQorCQllbHNlIHsNCisJCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJTX1gsIHgp
Ow0KKwkJCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBBQlNfWSwgeSk7DQorCQl9DQogCX0NCiANCi0J
aW5wdXRfcmVwb3J0X2FicyhkZXYsIEFCU19QUkVTU1VSRSwgKGRhdGFbMl0gJiAxKSA8PCA3IHwg
KGRhdGFbNV0gJiAweDdGKSk7DQotCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBCVE5fVE9VQ0gsIH5k
YXRhWzddICYgMHgyMCk7DQorCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBBQlNfUFJFU1NVUkUsIGFi
cyk7DQorCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBCVE5fVE9VQ0gsIGJ1dHRvbik7DQorDQorCS8q
IElmIHlvdSBhcmUgZXhwZXJpZW5jaW5nIGRvdWJsZSBjbGlja3MsIHR1cm4gb2ZmICJpbnB1dF9z
eW5jKGRldikiLiAqLw0KIAlpbnB1dF9zeW5jKGRldik7DQogDQogZXhpdDoNCi0JcmV0dmFsID0g
dXNiX3N1Ym1pdF91cmIgKHVyYiwgR0ZQX0FUT01JQyk7DQorCXJldHZhbCA9IHVzYl9zdWJtaXRf
dXJiKHVyYiwgR0ZQX0FUT01JQyk7DQogCWlmIChyZXR2YWwpDQogCQlwcmludGsoS0VSTl9FUlIg
IiVzIC0gdXNiX3N1Ym1pdF91cmIgZmFpbGVkIHdpdGggcmVzdWx0OiAlZCIsDQogCQkJCV9fRlVO
Q1RJT05fXywgcmV0dmFsKTsNCkBAIC0yMTAsOCArMjYwLDE0IEBADQogCQlyZXR1cm4gLUVOT01F
TTsNCiAJfQ0KIA0KLQl1c2JfZmlsbF9pbnRfdXJiKGl0bXRvdWNoLT5yZWFkdXJiLCBpdG10b3Vj
aC0+dXNiZGV2LCBwaXBlLCBpdG10b3VjaC0+cmJ1ZiwNCi0JCQkgbWF4cCwgaXRtdG91Y2hfaXJx
LCBpdG10b3VjaCwgZW5kcG9pbnQtPmJJbnRlcnZhbCk7DQorCXVzYl9maWxsX2ludF91cmIoaXRt
dG91Y2gtPnJlYWR1cmIsDQorCQkJaXRtdG91Y2gtPnVzYmRldiwNCisJCQlwaXBlLA0KKwkJCWl0
bXRvdWNoLT5yYnVmLA0KKwkJCW1heHAsDQorCQkJaXRtdG91Y2hfaXJxLA0KKwkJCWl0bXRvdWNo
LA0KKwkJCWVuZHBvaW50LT5iSW50ZXJ2YWwpOw0KIA0KIAlpbnB1dF9yZWdpc3Rlcl9kZXZpY2Uo
Jml0bXRvdWNoLT5pbnB1dGRldik7DQogDQo=


--=-5zDyK4G1G1mtaNuozK2Z--
