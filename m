Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266523AbUGPVqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUGPVqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUGPVqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 17:46:54 -0400
Received: from imap.gmx.net ([213.165.64.20]:21445 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266523AbUGPVqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 17:46:34 -0400
X-Authenticated: #20450766
Date: Fri, 16 Jul 2004 23:27:04 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Adrian Bunk <bunk@fs.tum.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI tmscsim.c: fix inline compile errors
In-Reply-To: <20040715224726.GQ25633@fs.tum.de>
Message-ID: <Pine.LNX.4.60.0407162316590.8195@poirot.grange>
References: <20040715224726.GQ25633@fs.tum.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1623236495-1090013224=:8195"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1623236495-1090013224=:8195
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi

On Fri, 16 Jul 2004, Adrian Bunk wrote:

> Trying to compile drivers/scsi/tmscsim.c in 2.6.8-rc1-mm1 using gcc 3.4
> results in compile errors starting with the following:
>
> <--  snip  -->
>
> ...
>  CC      drivers/scsi/tmscsim.o
> In file included from drivers/scsi/tmscsim.c:1477:
> drivers/scsi/scsiiom.c: In function `do_DC390_Interrupt':
> drivers/scsi/tmscsim.c:295: sorry, unimplemented: inlining failed in
> call to 'dc390_InvalidCmd': function body not available
> drivers/scsi/scsiiom.c:279: sorry, unimplemented: called from here
> drivers/scsi/tmscsim.c:296: sorry, unimplemented: inlining failed in
> call to 'dc390_EnableMsgOut_Abort': function body not available
> drivers/scsi/scsiiom.c:317: sorry, unimplemented: called from here
> make[2]: *** [drivers/scsi/tmscsim.o] Error 1
>
> <--  snip  -->
>
>
> The patch below removes the inlines from the affected functions.
>
> An alternative approach would be to move the functions above the place
> where they are called the first time.

Thanks for the patch!

I looked at those 3 functions. dc390_EnableMsgOut_Abort is called 5 times 
in the code and is 0x30 bytes long (as compiled with 3.3.2), so, 
uninlining it, probably, makes most sense. The other 2 functions are 
called only ones each and from the interrupt, so, I applied the 
"alternative approach" to them - moved above the calling functions. So, if 
there are no objections, perhaps, the attached patch could be applied 
instead of yours. Tested.

Thanks
Guennadi

>
>
>
> diffstat output:
> drivers/scsi/scsiiom.c |    6 +++---
> drivers/scsi/tmscsim.c |    6 +++---
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
>
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
>
> --- linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/scsiiom.c.old	2004-07-09 01:31:13.000000000 +0200
> +++ linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/scsiiom.c	2004-07-09 01:33:35.000000000 +0200
> @@ -594,7 +594,7 @@
> }
>
> /* abort command */
> -static void __inline__
> +static void
> dc390_EnableMsgOut_Abort ( struct dc390_acb* pACB, struct dc390_srb* pSRB )
> {
>     pSRB->MsgOutBuf[0] = ABORT;
> @@ -1656,7 +1656,7 @@
> }
>
>
> -static void __inline__
> +static void
> dc390_RequestSense( struct dc390_acb* pACB, struct dc390_dcb* pDCB, struct dc390_srb* pSRB )
> {
>     struct scsi_cmnd *pcmd;
> @@ -1696,7 +1696,7 @@
>
>
>
> -static void __inline__
> +static void
> dc390_InvalidCmd( struct dc390_acb* pACB )
> {
>     if( pACB->pActiveDCB->pActiveSRB->SRBState & (SRB_START_+SRB_MSGOUT) )
> --- linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/tmscsim.c.old	2004-07-09 01:29:36.000000000 +0200
> +++ linux-2.6.7-mm6-full-gcc3.4/drivers/scsi/tmscsim.c	2004-07-09 01:33:46.000000000 +0200
> @@ -291,9 +291,9 @@
> static void dc390_DoingSRB_Done( struct dc390_acb* pACB, struct scsi_cmnd * cmd);
> static void dc390_ScsiRstDetect( struct dc390_acb* pACB );
> static void dc390_ResetSCSIBus( struct dc390_acb* pACB );
> -static void __inline__ dc390_RequestSense( struct dc390_acb* pACB, struct dc390_dcb* pDCB, struct dc390_srb* pSRB );
> -static void __inline__ dc390_InvalidCmd( struct dc390_acb* pACB );
> -static void __inline__ dc390_EnableMsgOut_Abort (struct dc390_acb*, struct dc390_srb*);
> +static void dc390_RequestSense( struct dc390_acb* pACB, struct dc390_dcb* pDCB, struct dc390_srb* pSRB );
> +static void dc390_InvalidCmd( struct dc390_acb* pACB );
> +static void dc390_EnableMsgOut_Abort (struct dc390_acb*, struct dc390_srb*);
> static irqreturn_t do_DC390_Interrupt( int, void *, struct pt_regs *);
>
> static int    dc390_initAdapter(struct Scsi_Host *psh, unsigned long io_port, u8 Irq, u8 index );
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

---
Guennadi Liakhovetski

---1463811839-1623236495-1090013224=:8195
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tmscsim-fix_inline.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0407162327040.8195@poirot.grange>
Content-Description: 
Content-Disposition: attachment; filename="tmscsim-fix_inline.patch"

U2lnbmVkLW9mZi1ieTogQWRyaWFuIEJ1bmsgPGJ1bmtAZnMudHVtLmRlPg0K
TW9kaWZpZWQgYW5kDQpTaWduZWQtb2ZmLWJ5OiBHdWVubmFkaSBMaWFraG92
ZXRza2kgPGcubGlha2hvdmV0c2tpQGdteC5kZT4NCg0KZGlmZiAtdSBhL2Ry
aXZlcnMvc2NzaS9zY3NpaW9tLmMgIGIvZHJpdmVycy9zY3NpL3Njc2lpb20u
Yw0KLS0tIGEvZHJpdmVycy9zY3NpL3Njc2lpb20uYwlGcmkgSnVsIDE2IDIy
OjQyOjM4IDIwMDQNCisrKyBiL2RyaXZlcnMvc2NzaS9zY3NpaW9tLmMJRnJp
IEp1bCAxNiAyMjo1ODoyOCAyMDA0DQpAQCAtMjEzLDggKzIxMywxNyBAQA0K
IH0NCiAjZW5kaWYNCiANCisNCitzdGF0aWMgdm9pZCBfX2lubGluZV9fDQor
ZGMzOTBfSW52YWxpZENtZChzdHJ1Y3QgZGMzOTBfYWNiKiBwQUNCKQ0KK3sN
CisJaWYgKHBBQ0ItPnBBY3RpdmVEQ0ItPnBBY3RpdmVTUkItPlNSQlN0YXRl
ICYgKFNSQl9TVEFSVF8gfCBTUkJfTVNHT1VUKSkNCisJCURDMzkwX3dyaXRl
OChTY3NpQ21kLCBDTEVBUl9GSUZPX0NNRCk7DQorfQ0KKw0KKw0KIHN0YXRp
YyBpcnFyZXR1cm5fdCBfX2lubGluZV9fDQotREMzOTBfSW50ZXJydXB0KCBp
bnQgaXJxLCB2b2lkICpkZXZfaWQsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0K
K0RDMzkwX0ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQsIHN0cnVj
dCBwdF9yZWdzICpyZWdzKQ0KIHsNCiAgICAgc3RydWN0IGRjMzkwX2FjYiAq
cEFDQiwgKnBBQ0IyOw0KICAgICBzdHJ1Y3QgZGMzOTBfZGNiICpwRENCOw0K
QEAgLTU5NCw3ICs2MDMsNyBAQA0KIH0NCiANCiAvKiBhYm9ydCBjb21tYW5k
ICovDQotc3RhdGljIHZvaWQgX19pbmxpbmVfXw0KK3N0YXRpYyB2b2lkDQog
ZGMzOTBfRW5hYmxlTXNnT3V0X0Fib3J0ICggc3RydWN0IGRjMzkwX2FjYiog
cEFDQiwgc3RydWN0IGRjMzkwX3NyYiogcFNSQiApDQogew0KICAgICBwU1JC
LT5Nc2dPdXRCdWZbMF0gPSBBQk9SVDsgDQpAQCAtMTMzMyw2ICsxMzQyLDM1
IEBADQogfQ0KIA0KIA0KK3N0YXRpYyB2b2lkIF9faW5saW5lX18NCitkYzM5
MF9SZXF1ZXN0U2Vuc2Uoc3RydWN0IGRjMzkwX2FjYiogcEFDQiwgc3RydWN0
IGRjMzkwX2RjYiogcERDQiwgc3RydWN0IGRjMzkwX3NyYiogcFNSQikNCit7
DQorCXN0cnVjdCBzY3NpX2NtbmQgKnBjbWQ7DQorDQorCXBjbWQgPSBwU1JC
LT5wY21kOw0KKw0KKwlSRU1PVkFCTEVERUJVRyhwcmludGsoS0VSTl9JTkZP
ICJEQzM5MDogUmVxdWVzdFNlbnNlKENtZCAlMDJ4LCBJZCAlMDJ4LCBMVU4g
JTAyeClcbiIsXA0KKwkJCSAgICAgIHBjbWQtPmNtbmRbMF0sIHBEQ0ItPlRh
cmdldElELCBwRENCLT5UYXJnZXRMVU4pKTsNCisNCisJcFNSQi0+U1JCRmxh
ZyB8PSBBVVRPX1JFUVNFTlNFOw0KKwlwU1JCLT5TYXZlZFNHQ291bnQgPSBw
Y21kLT51c2Vfc2c7DQorCXBTUkItPlNhdmVkVG90WExlbiA9IHBTUkItPlRv
dGFsWGZlcnJlZExlbjsNCisJcFNSQi0+QWRhcHRTdGF0dXMgPSAwOw0KKwlw
U1JCLT5UYXJnZXRTdGF0dXMgPSAwOyAvKiBDSEVDS19DT05ESVRJT048PDE7
ICovDQorDQorCS8qIFdlIGFyZSBjYWxsZWQgZnJvbSBTUkJkb25lLCBvcmln
aW5hbCBQQ0kgbWFwcGluZyBoYXMgYmVlbiByZW1vdmVkDQorCSAqIGFscmVh
ZHksIG5ldyBvbmUgaXMgc2V0IHVwIGZyb20gU3RhcnRTQ1NJICovDQorCXBT
UkItPlNHSW5kZXggPSAwOw0KKw0KKwlwU1JCLT5Ub3RhbFhmZXJyZWRMZW4g
PSAwOw0KKwlwU1JCLT5TR1RvQmVYZmVyTGVuID0gMDsNCisJaWYgKGRjMzkw
X1N0YXJ0U0NTSShwQUNCLCBwRENCLCBwU1JCKSkgew0KKwkJZGMzOTBfR29p
bmdfdG9fV2FpdGluZyhwRENCLCBwU1JCKTsNCisJCWRjMzkwX3dhaXRpbmdf
dGltZXIocEFDQiwgSFovNSk7DQorCX0NCit9DQorDQorDQogc3RhdGljIHZv
aWQNCiBkYzM5MF9TUkJkb25lKCBzdHJ1Y3QgZGMzOTBfYWNiKiBwQUNCLCBz
dHJ1Y3QgZGMzOTBfZGNiKiBwRENCLCBzdHJ1Y3QgZGMzOTBfc3JiKiBwU1JC
ICkNCiB7DQpAQCAtMTY0OSw1MiArMTY4Nyw0IEBADQogCWRjMzkwX1dhaXRp
bmdfcHJvY2VzcyggcEFDQiApOw0KICAgICB9DQogICAgIHJldHVybjsNCi19
DQotDQotDQotc3RhdGljIHZvaWQgX19pbmxpbmVfXw0KLWRjMzkwX1JlcXVl
c3RTZW5zZSggc3RydWN0IGRjMzkwX2FjYiogcEFDQiwgc3RydWN0IGRjMzkw
X2RjYiogcERDQiwgc3RydWN0IGRjMzkwX3NyYiogcFNSQiApDQotew0KLSAg
ICBzdHJ1Y3Qgc2NzaV9jbW5kICpwY21kOw0KLQ0KLSAgICBwY21kID0gcFNS
Qi0+cGNtZDsNCi0NCi0gICAgUkVNT1ZBQkxFREVCVUcocHJpbnRrIChLRVJO
X0lORk8gIkRDMzkwOiBSZXF1ZXN0U2Vuc2UgKENtZCAlMDJ4LCBJZCAlMDJ4
LCBMVU4gJTAyeClcbiIsXA0KLQkgICAgcGNtZC0+Y21uZFswXSwgcERDQi0+
VGFyZ2V0SUQsIHBEQ0ItPlRhcmdldExVTikpOw0KLQ0KLSAgICBwU1JCLT5T
UkJGbGFnIHw9IEFVVE9fUkVRU0VOU0U7DQotICAgIC8vcFNSQi0+U2VnbWVu
dDBbMF0gPSAodTMyKSBwU1JCLT5DbWRCbG9ja1swXTsNCi0gICAgLy9wU1JC
LT5TZWdtZW50MFsxXSA9ICh1MzIpIHBTUkItPkNtZEJsb2NrWzRdOw0KLSAg
ICAvL3BTUkItPlNlZ21lbnQxWzBdID0gKCh1MzIpKHBjbWQtPmNtZF9sZW4p
IDw8IDgpICsgcFNSQi0+U0djb3VudDsNCi0gICAgLy9wU1JCLT5TZWdtZW50
MVsxXSA9IHBTUkItPlRvdGFsWGZlcnJlZExlbjsNCi0gICAgcFNSQi0+U2F2
ZWRTR0NvdW50ID0gcGNtZC0+dXNlX3NnOw0KLSAgICBwU1JCLT5TYXZlZFRv
dFhMZW4gPSBwU1JCLT5Ub3RhbFhmZXJyZWRMZW47DQotICAgIHBTUkItPkFk
YXB0U3RhdHVzID0gMDsNCi0gICAgcFNSQi0+VGFyZ2V0U3RhdHVzID0gMDsg
LyogQ0hFQ0tfQ09ORElUSU9OPDwxOyAqLw0KLQ0KLSAgICAvKiBXZSBhcmUg
Y2FsbGVkIGZyb20gU1JCZG9uZSwgb3JpZ2luYWwgUENJIG1hcHBpbmcgaGFz
IGJlZW4gcmVtb3ZlZA0KLSAgICAgKiBhbHJlYWR5LCBuZXcgb25lIGlzIHNl
dCB1cCBmcm9tIFN0YXJ0U0NTSSAqLw0KLSAgICBwU1JCLT5TR0luZGV4ID0g
MDsNCi0NCi0gICAgLy9wU1JCLT5DbWRCbG9ja1swXSA9IFJFUVVFU1RfU0VO
U0U7DQotICAgIC8vcFNSQi0+Q21kQmxvY2tbMV0gPSBwRENCLT5UYXJnZXRM
VU4gPDwgNTsNCi0gICAgLy8odTE2KSBwU1JCLT5DbWRCbG9ja1syXSA9IDA7
DQotICAgIC8vKHUxNikgcFNSQi0+Q21kQmxvY2tbNF0gPSBzaXplb2YocGNt
ZC0+c2Vuc2VfYnVmZmVyKTsNCi0gICAgLy9wU1JCLT5TY3NpQ21kTGVuID0g
NjsNCi0NCi0gICAgcFNSQi0+VG90YWxYZmVycmVkTGVuID0gMDsNCi0gICAg
cFNSQi0+U0dUb0JlWGZlckxlbiA9IDA7DQotICAgIGlmKCBkYzM5MF9TdGFy
dFNDU0koIHBBQ0IsIHBEQ0IsIHBTUkIgKSApIHsNCi0JZGMzOTBfR29pbmdf
dG9fV2FpdGluZyAoIHBEQ0IsIHBTUkIgKTsNCi0JZGMzOTBfd2FpdGluZ190
aW1lciAocEFDQiwgSFovNSk7DQotICAgIH0NCi19DQotDQotDQotDQotc3Rh
dGljIHZvaWQgX19pbmxpbmVfXw0KLWRjMzkwX0ludmFsaWRDbWQoIHN0cnVj
dCBkYzM5MF9hY2IqIHBBQ0IgKQ0KLXsNCi0gICAgaWYoIHBBQ0ItPnBBY3Rp
dmVEQ0ItPnBBY3RpdmVTUkItPlNSQlN0YXRlICYgKFNSQl9TVEFSVF8rU1JC
X01TR09VVCkgKQ0KLQlEQzM5MF93cml0ZTggKFNjc2lDbWQsIENMRUFSX0ZJ
Rk9fQ01EKTsNCiB9DQpkaWZmIC11IGEvZHJpdmVycy9zY3NpL3Rtc2NzaW0u
YyAgYi9kcml2ZXJzL3Njc2kvdG1zY3NpbS5jDQotLS0gYS9kcml2ZXJzL3Nj
c2kvdG1zY3NpbS5jCUZyaSBKdWwgMTYgMjI6NDA6NDEgMjAwNA0KKysrIGIv
ZHJpdmVycy9zY3NpL3Rtc2NzaW0uYwlGcmkgSnVsIDE2IDIzOjAxOjA4IDIw
MDQNCkBAIC0yODksOSArMjg5LDcgQEANCiBzdGF0aWMgdm9pZCBkYzM5MF9E
b2luZ1NSQl9Eb25lKCBzdHJ1Y3QgZGMzOTBfYWNiKiBwQUNCLCBzdHJ1Y3Qg
c2NzaV9jbW5kICogY21kKTsNCiBzdGF0aWMgdm9pZCBkYzM5MF9TY3NpUnN0
RGV0ZWN0KCBzdHJ1Y3QgZGMzOTBfYWNiKiBwQUNCICk7DQogc3RhdGljIHZv
aWQgZGMzOTBfUmVzZXRTQ1NJQnVzKCBzdHJ1Y3QgZGMzOTBfYWNiKiBwQUNC
ICk7DQotc3RhdGljIHZvaWQgX19pbmxpbmVfXyBkYzM5MF9SZXF1ZXN0U2Vu
c2UoIHN0cnVjdCBkYzM5MF9hY2IqIHBBQ0IsIHN0cnVjdCBkYzM5MF9kY2Iq
IHBEQ0IsIHN0cnVjdCBkYzM5MF9zcmIqIHBTUkIgKTsNCi1zdGF0aWMgdm9p
ZCBfX2lubGluZV9fIGRjMzkwX0ludmFsaWRDbWQoIHN0cnVjdCBkYzM5MF9h
Y2IqIHBBQ0IgKTsNCi1zdGF0aWMgdm9pZCBfX2lubGluZV9fIGRjMzkwX0Vu
YWJsZU1zZ091dF9BYm9ydCAoc3RydWN0IGRjMzkwX2FjYiosIHN0cnVjdCBk
YzM5MF9zcmIqKTsNCitzdGF0aWMgdm9pZCBkYzM5MF9FbmFibGVNc2dPdXRf
QWJvcnQoc3RydWN0IGRjMzkwX2FjYiosIHN0cnVjdCBkYzM5MF9zcmIqKTsN
CiBzdGF0aWMgaXJxcmV0dXJuX3QgZG9fREMzOTBfSW50ZXJydXB0KCBpbnQs
IHZvaWQgKiwgc3RydWN0IHB0X3JlZ3MgKik7DQogDQogc3RhdGljIGludCAg
ICBkYzM5MF9pbml0QWRhcHRlcihzdHJ1Y3QgU2NzaV9Ib3N0ICpwc2gsIHVu
c2lnbmVkIGxvbmcgaW9fcG9ydCwgdTggSXJxLCB1OCBpbmRleCApOw0KQEAg
LTkzOSw4ICs5MzcsNiBAQA0KIHsNCiAgICAgcFNSQi0+cFNSQkRDQiA9IHBE
Q0I7DQogICAgIHBTUkItPnBjbWQgPSBwY21kOw0KLSAgICAvL3BTUkItPlNj
c2lDbWRMZW4gPSBwY21kLT5jbWRfbGVuOw0KLSAgICAvL21lbWNweSAocFNS
Qi0+Q21kQmxvY2ssIHBjbWQtPmNtbmQsIHBjbWQtPmNtZF9sZW4pOw0KICAg
ICANCiAgICAgcFNSQi0+U0dJbmRleCA9IDA7DQogICAgIHBTUkItPkFkYXB0
U3RhdHVzID0gMDsNCg==

---1463811839-1623236495-1090013224=:8195--
