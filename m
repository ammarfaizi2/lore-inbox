Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbTDRNmg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 09:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbTDRNmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 09:42:35 -0400
Received: from pop.gmx.net ([213.165.64.20]:61752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263040AbTDRNmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 09:42:31 -0400
Message-Id: <5.2.0.9.2.20030418145953.00cb4068@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 18 Apr 2003 15:58:41 +0200
To: Jens Axboe <axboe@suse.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Cc: Con Kolivas <kernel@kolivas.org>, Robert Love <rml@tech9.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030331063548.GQ917@suse.de>
References: <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
 <20030330141404.GG917@suse.de>
 <3E8610EA.8080309@telia.com>
 <1048992365.13757.23.camel@localhost>
 <20030330141404.GG917@suse.de>
 <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_38529750==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_38529750==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 08:35 AM 3/31/2003 +0200, Jens Axboe wrote:
>On Mon, Mar 31 2003, Mike Galbraith wrote:
> > At 07:06 AM 3/31/2003 +1000, Con Kolivas wrote:
> > >On Mon, 31 Mar 2003 00:14, Jens Axboe wrote:
> > >> On Sat, Mar 29 2003, Robert Love wrote:
> > >> > On Sat, 2003-03-29 at 21:33, Con Kolivas wrote:
> > >> > > Are you sure this should be called a bug? Basically X is an
> > >interactive
> > >> > > process. If it now is "interactive for a priority -10 process" then
> > >it
> > >> > > should be hogging the cpu time no? The priority -10 was a workaround
> > >> > > for lack of interactivity estimation on the old scheduler.
> > >> >
> > >> > Well, I do not necessarily think that renicing X is the problem.  Just
> > >> > an idea.
> > >>
> > >> I see the exact same behaviour here (systems appears fine, cpu intensive
> > >> app running, attempting to start anything _new_ stalls for ages), and I
> > >> definitely don't play X renice tricks.
> > >>
> > >> It basically made 2.5 unusable here, waiting minutes for an ls to even
> > >> start displaying _anything_ is totally unacceptable.
> > >
> > >I guess I should have trusted my own benchmark that was showing this was
> > >worse
> > >for system responsiveness.
> >
> > I don't think it's really bad for system responsiveness.  I think the
>
>What drugs are you on? 2.5.65/66 is the worst interactive kernel I've
>ever used, it would be _embarassing_ to release a 2.6-test with such a
>rudimentary flaw in it. IOW, a big show stopper.

Hehehe... try the attached if you're brave.  It took me a loooong time to 
get backboost to work right.  Mainly because backboost wasn't really broken 
:)))  This patch _needs_ backboost to work, (see sleep_avg_tick()) and it 
does seem to do the job very nicely.

> > problem is just that the sample is too small.  The proof is that simply
> > doing sleep_time %= HZ cures most of my woes.  WRT contest and it's

The real problem is that there is no information in the fact that you were 
in lala land for a year or so.  Just because you slept through lunch, 
there's nothing that says you'll be a good mood afterward.  The useful 
information is the fact that someone else got a chance at the cpu, and 
you're only a really nice guy if you share a lot.  Take a look at what I 
did to activate_task()... if you slept for a short time, use that 
information.  If you slept for a long time, you get exactly what you need 
to finish your time slice.  This isn't subject to the number of tasks 
queued up, so the mistakes are smaller.  I also dispose of mistakes faster 
to make sure that interactive tasks (which aren't once they start running a 
lot) don't eat ages of cpu.  With this patch, I can get more than one task 
from a make -j30 bzImage in an ext3 partition to run concurrently, _and_ X 
is wonderful as well (gee, I really can have my cake and eat it too:).

>  Irk, that sounds like a really ugly bandaid.

Well,  it was just tossing the most damaging part of the problem into the 
bit bucket.

Anyway, anyone who thinks the scheduler is still unfair, or el-sucko in any 
way should feel free to beat upon this experiment.  I really like this 
one... think I'll even keep my fingers off it for a few minutes ;-)

         -Mike

Yeah, some of it _is_ gratuitous, but heck, it's almost pure research.  (no 
kaBoOMs... yet) 
--=====================_38529750==_
Content-Type: application/octet-stream; name="2567sched.diff";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2567sched.diff"

LS0tIGtlcm5lbC9zY2hlZC5jLm9yZwlUaHUgQXByIDE3IDA1OjM4OjQwIDIwMDMKKysrIGtlcm5l
bC9zY2hlZC5jCUZyaSBBcHIgMTggMTM6MzU6NDAgMjAwMwpAQCAtNjYsMTQgKzY2LDE1IEBACiAg
Ki8KICNkZWZpbmUgTUlOX1RJTUVTTElDRQkJKCAxMCAqIEhaIC8gMTAwMCkKICNkZWZpbmUgTUFY
X1RJTUVTTElDRQkJKDIwMCAqIEhaIC8gMTAwMCkKLSNkZWZpbmUgQ0hJTERfUEVOQUxUWQkJNTAK
KyNkZWZpbmUgQ0hJTERfUEVOQUxUWQkJNzUKICNkZWZpbmUgUEFSRU5UX1BFTkFMVFkJCTEwMAog
I2RlZmluZSBFWElUX1dFSUdIVAkJMwogI2RlZmluZSBQUklPX0JPTlVTX1JBVElPCTI1CiAjZGVm
aW5lIElOVEVSQUNUSVZFX0RFTFRBCTIKLSNkZWZpbmUgTUFYX1NMRUVQX0FWRwkJKDEwKkhaKQot
I2RlZmluZSBTVEFSVkFUSU9OX0xJTUlUCSgxMCpIWikKKyNkZWZpbmUgTUFYX1NMRUVQX0FWRwkJ
KDEwICogSFopCisjZGVmaW5lIFNUQVJWQVRJT05fTElNSVQJKE1BWF9TTEVFUF9BVkcgLyAyKQog
I2RlZmluZSBOT0RFX1RIUkVTSE9MRAkJMTI1CisjZGVmaW5lIFRJTUVTTElDRV9HUkFOVUxBUklU
WQkoSFovMjAgPzogMSkKIAogLyoKICAqIElmIGEgdGFzayBpcyAnaW50ZXJhY3RpdmUnIHRoZW4g
d2UgcmVpbnNlcnQgaXQgaW4gdGhlIGFjdGl2ZQpAQCAtMTI0LDEyICsxMjUsMTcgQEAKICAqIHRh
c2tfdGltZXNsaWNlKCkgaXMgdGhlIGludGVyZmFjZSB0aGF0IGlzIHVzZWQgYnkgdGhlIHNjaGVk
dWxlci4KICAqLwogCi0jZGVmaW5lIEJBU0VfVElNRVNMSUNFKHApIChNSU5fVElNRVNMSUNFICsg
XAotCSgoTUFYX1RJTUVTTElDRSAtIE1JTl9USU1FU0xJQ0UpICogKE1BWF9QUklPLTEtKHApLT5z
dGF0aWNfcHJpbykvKE1BWF9VU0VSX1BSSU8gLSAxKSkpCisjZGVmaW5lIEJBU0VfVElNRVNMSUNF
KHApIFwKKwkoTUFYX1RJTUVTTElDRSAqIChNQVhfUFJJTy0ocCktPnN0YXRpY19wcmlvKS9NQVhf
VVNFUl9QUklPKQogCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCB0YXNrX3RpbWVzbGljZSh0
YXNrX3QgKnApCiB7Ci0JcmV0dXJuIEJBU0VfVElNRVNMSUNFKHApOworCXVuc2lnbmVkIGludCB0
aW1lX3NsaWNlID0gQkFTRV9USU1FU0xJQ0UocCk7CisKKwlpZiAodGltZV9zbGljZSA8IE1JTl9U
SU1FU0xJQ0UpCisJCXRpbWVfc2xpY2UgPSBNSU5fVElNRVNMSUNFOworCisJcmV0dXJuIHRpbWVf
c2xpY2U7CiB9CiAKIC8qCkBAIC0yNzksNiArMjg1LDcgQEAKICAqLwogc3RhdGljIGlubGluZSB2
b2lkIGRlcXVldWVfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHByaW9fYXJyYXlfdCAqYXJy
YXkpCiB7CisJcC0+YXJyYXkgPSBOVUxMOwogCWFycmF5LT5ucl9hY3RpdmUtLTsKIAlsaXN0X2Rl
bCgmcC0+cnVuX2xpc3QpOwogCWlmIChsaXN0X2VtcHR5KGFycmF5LT5xdWV1ZSArIHAtPnByaW8p
KQpAQCAtMzQwLDEzICszNDcsMTYgQEAKICAqIFVwZGF0ZSBhbGwgdGhlIHNjaGVkdWxpbmcgc3Rh
dGlzdGljcyBzdHVmZi4gKHNsZWVwIGF2ZXJhZ2UKICAqIGNhbGN1bGF0aW9uLCBwcmlvcml0eSBt
b2RpZmllcnMsIGV0Yy4pCiAgKi8KKyNkZWZpbmUgTUFZX0JBQ0tCT09TVCBcCisJKCFpbl9pbnRl
cnJ1cHQoKSAmJiAhVEFTS19OSUNFKGN1cnJlbnQpICYmICFUQVNLX05JQ0UocCkpCisKIHN0YXRp
YyBpbmxpbmUgaW50IGFjdGl2YXRlX3Rhc2sodGFza190ICpwLCBydW5xdWV1ZV90ICpycSkKIHsK
IAlsb25nIHNsZWVwX3RpbWUgPSBqaWZmaWVzIC0gcC0+bGFzdF9ydW4gLSAxOwogCWludCByZXF1
ZXVlX3dha2VyID0gMDsKIAogCWlmIChzbGVlcF90aW1lID4gMCkgewotCQlpbnQgc2xlZXBfYXZn
OworCQlpbnQgc2xlZXBfYXZnID0gcC0+c2xlZXBfYXZnOwogCiAJCS8qCiAJCSAqIFRoaXMgY29k
ZSBnaXZlcyBhIGJvbnVzIHRvIGludGVyYWN0aXZlIHRhc2tzLgpAQCAtMzU2LDcgKzM2Niw3IEBA
CiAJCSAqIHNwZW5kcyBzbGVlcGluZywgdGhlIGhpZ2hlciB0aGUgYXZlcmFnZSBnZXRzIC0gYW5k
IHRoZQogCQkgKiBoaWdoZXIgdGhlIHByaW9yaXR5IGJvb3N0IGdldHMgYXMgd2VsbC4KIAkJICov
Ci0JCXNsZWVwX2F2ZyA9IHAtPnNsZWVwX2F2ZyArIHNsZWVwX3RpbWU7CisJCXNsZWVwX2F2ZyAr
PSBtaW4oc2xlZXBfdGltZSwgKGxvbmcpIHAtPnRpbWVfc2xpY2UpOwogCiAJCS8qCiAJCSAqICdP
dmVyZmxvdycgYm9udXMgdGlja3MgZ28gdG8gdGhlIHdha2VyIGFzIHdlbGwsIHNvIHRoZQpAQCAt
MzY0LDggKzM3NCwyMyBAQAogCQkgKiBib29zdGluZyB0YXNrcyB0aGF0IGFyZSByZWxhdGVkIHRv
IG1heGltdW0taW50ZXJhY3RpdmUKIAkJICogdGFza3MuCiAJCSAqLwotCQlpZiAoc2xlZXBfYXZn
ID4gTUFYX1NMRUVQX0FWRykKKwkJaWYgKHNsZWVwX2F2ZyA+IE1BWF9TTEVFUF9BVkcpIHsKKwkJ
CWlmIChNQVlfQkFDS0JPT1NUKSB7CisjaWYgMAorCQkJCXByaW50ayhLRVJOX0RFQlVHICIlbHU6
ICVkIGJvb3N0ZWQgJWQgYnkgJWRcbiIsCisJCQkJCWppZmZpZXMsIHAtPnBpZCwgY3VycmVudC0+
cGlkLCBzbGVlcF9hdmctTUFYX1NMRUVQX0FWRyk7CisjZW5kaWYKKwkJCQlzbGVlcF9hdmcgKz0g
Y3VycmVudC0+c2xlZXBfYXZnIC0gTUFYX1NMRUVQX0FWRzsKKwkJCQlpZiAoc2xlZXBfYXZnID4g
TUFYX1NMRUVQX0FWRykKKwkJCQkJc2xlZXBfYXZnID0gTUFYX1NMRUVQX0FWRzsKKworCQkJCWlm
IChjdXJyZW50LT5zbGVlcF9hdmcgIT0gc2xlZXBfYXZnKSB7CisJCQkJCWN1cnJlbnQtPnNsZWVw
X2F2ZyA9IHNsZWVwX2F2ZzsKKwkJCQkJcmVxdWV1ZV93YWtlciA9IDE7CisJCQkJfQorCQkJfQog
CQkJc2xlZXBfYXZnID0gTUFYX1NMRUVQX0FWRzsKKwkJfQogCQlpZiAocC0+c2xlZXBfYXZnICE9
IHNsZWVwX2F2ZykgewogCQkJcC0+c2xlZXBfYXZnID0gc2xlZXBfYXZnOwogCQkJcC0+cHJpbyA9
IGVmZmVjdGl2ZV9wcmlvKHApOwpAQCAtMzgxLDExICs0MDYsMTAgQEAKICAqLwogc3RhdGljIGlu
bGluZSB2b2lkIGRlYWN0aXZhdGVfdGFzayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHJ1bnF1ZXVl
X3QgKnJxKQogewotCW5yX3J1bm5pbmdfZGVjKHJxKTsKKwlkZXF1ZXVlX3Rhc2socCwgcC0+YXJy
YXkpOwogCWlmIChwLT5zdGF0ZSA9PSBUQVNLX1VOSU5URVJSVVBUSUJMRSkKIAkJcnEtPm5yX3Vu
aW50ZXJydXB0aWJsZSsrOwotCWRlcXVldWVfdGFzayhwLCBwLT5hcnJheSk7Ci0JcC0+YXJyYXkg
PSBOVUxMOworCW5yX3J1bm5pbmdfZGVjKHJxKTsKIH0KIAogLyoKQEAgLTU2OSw3ICs1OTMsMTAg
QEAKIAkgKiBmcm9tIGZvcmtpbmcgdGFza3MgdGhhdCBhcmUgbWF4LWludGVyYWN0aXZlLgogCSAq
LwogCWN1cnJlbnQtPnNsZWVwX2F2ZyA9IGN1cnJlbnQtPnNsZWVwX2F2ZyAqIFBBUkVOVF9QRU5B
TFRZIC8gMTAwOwotCXAtPnNsZWVwX2F2ZyA9IHAtPnNsZWVwX2F2ZyAqIENISUxEX1BFTkFMVFkg
LyAxMDA7CisJaWYgKGxpa2VseShjdXJyZW50LT5wYXJlbnQtPnBpZCA+IDEpKQorCQlwLT5zbGVl
cF9hdmcgPSBjdXJyZW50LT5zbGVlcF9hdmcgKiBDSElMRF9QRU5BTFRZIC8gMTAwOworCWVsc2UK
KwkJcC0+c2xlZXBfYXZnID0gY3VycmVudC0+c2xlZXBfYXZnID0gTUFYX1NMRUVQX0FWRzsKIAlw
LT5wcmlvID0gZWZmZWN0aXZlX3ByaW8ocCk7CiAJc2V0X3Rhc2tfY3B1KHAsIHNtcF9wcm9jZXNz
b3JfaWQoKSk7CiAKQEAgLTU5NiwyMiArNjIzLDIwIEBACiAgKi8KIHZvaWQgc2NoZWRfZXhpdCh0
YXNrX3QgKiBwKQogewotCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Ci0KLQlsb2NhbF9pcnFfc2F2ZShm
bGFncyk7CiAJaWYgKHAtPmZpcnN0X3RpbWVfc2xpY2UpIHsKIAkJcC0+cGFyZW50LT50aW1lX3Ns
aWNlICs9IHAtPnRpbWVfc2xpY2U7CiAJCWlmICh1bmxpa2VseShwLT5wYXJlbnQtPnRpbWVfc2xp
Y2UgPiBNQVhfVElNRVNMSUNFKSkKIAkJCXAtPnBhcmVudC0+dGltZV9zbGljZSA9IE1BWF9USU1F
U0xJQ0U7CiAJfQotCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKIAkvKgogCSAqIElmIHRoZSBj
aGlsZCB3YXMgYSAocmVsYXRpdmUtKSBDUFUgaG9nIHRoZW4gZGVjcmVhc2UKIAkgKiB0aGUgc2xl
ZXBfYXZnIG9mIHRoZSBwYXJlbnQgYXMgd2VsbC4KIAkgKi8KLQlpZiAocC0+c2xlZXBfYXZnIDwg
cC0+cGFyZW50LT5zbGVlcF9hdmcpCisjaWYgMAorCWlmIChwLT5wYXJlbnQtPnBpZCA+IDEgJiYg
cC0+c2xlZXBfYXZnIDwgcC0+cGFyZW50LT5zbGVlcF9hdmcpCiAJCXAtPnBhcmVudC0+c2xlZXBf
YXZnID0gKHAtPnBhcmVudC0+c2xlZXBfYXZnICogRVhJVF9XRUlHSFQgKwotCQkJcC0+c2xlZXBf
YXZnKSAvIChFWElUX1dFSUdIVCArIDEpOworCQkJcC0+c2xlZXBfYXZnKSAvIE1BWF9VU0VSX1BS
SU87CisjZW5kaWYKIH0KIAogLyoqCkBAIC0xMTYxLDE0ICsxMTg2LDI5IEBACiAgKgogICogVG8g
Z3VhcmFudGVlIHRoYXQgdGhpcyBkb2VzIG5vdCBzdGFydmUgZXhwaXJlZCB0YXNrcyB3ZSBpZ25v
cmUgdGhlCiAgKiBpbnRlcmFjdGl2aXR5IG9mIGEgdGFzayBpZiB0aGUgZmlyc3QgZXhwaXJlZCB0
YXNrIGhhZCB0byB3YWl0IG1vcmUKLSAqIHRoYW4gYSAncmVhc29uYWJsZScgYW1vdW50IG9mIHRp
bWUuIFRoaXMgZGVhZGxpbmUgdGltZW91dCBpcwotICogbG9hZC1kZXBlbmRlbnQsIGFzIHRoZSBm
cmVxdWVuY3kgb2YgYXJyYXkgc3dpdGNoZWQgZGVjcmVhc2VzIHdpdGgKLSAqIGluY3JlYXNpbmcg
bnVtYmVyIG9mIHJ1bm5pbmcgdGFza3M6CisgKiB0aGFuIGEgJ3JlYXNvbmFibGUnIGFtb3VudCBv
ZiB0aW1lLgogICovCiAjZGVmaW5lIEVYUElSRURfU1RBUlZJTkcocnEpIFwKLQkJKFNUQVJWQVRJ
T05fTElNSVQgJiYgKChycSktPmV4cGlyZWRfdGltZXN0YW1wICYmIFwKLQkJKGppZmZpZXMgLSAo
cnEpLT5leHBpcmVkX3RpbWVzdGFtcCA+PSBcCi0JCQlTVEFSVkFUSU9OX0xJTUlUICogKChycSkt
Pm5yX3J1bm5pbmcpICsgMSkpKQorCQkoU1RBUlZBVElPTl9MSU1JVCAmJiAocnEpLT5leHBpcmVk
X3RpbWVzdGFtcCAmJiBcCisJCXRpbWVfYWZ0ZXIoamlmZmllcywgKHJxKS0+ZXhwaXJlZF90aW1l
c3RhbXAgKyBTVEFSVkFUSU9OX0xJTUlUKSkKKworLyoKKyAqIFNjYWxlIHRoZSBjcHUgdXNhZ2Ug
cGVuYWx0eSBmb3IgdGFza3Mgd2hpY2ggYXJlIG5vdCBuaWNlZCB0byBiZWxvdworICogemVybyBi
eSB0aGVpciBuaWNlIHZhbHVlIGFuZCBpbnRlcmFjdGl2aXR5LiAgU2ltcGx5IGJlY2F1c2UgYSB0
YXNrCisgKiBoYXMgYmVlbiBuaWNlIHJlY2VudGx5IGRvZXMgTk9UIG1lYW4gaXQgc2hvdWxkIGJl
IGFsbG93ZWQgMyBzZWNvbmRzCisgKiBvZiBjcHUgYmVmb3JlIGl0IHdpbGwgYmUgZXhwaXJlZC4K
KyAqLworc3RhdGljIGlubGluZSB2b2lkIHNsZWVwX2F2Z190aWNrKHRhc2tfdCAqcCkKK3sKKwlp
bnQgYmlhcyA9IDEsIG5pY2UgPSBUQVNLX05JQ0UocCk7CisKKwlpZiAobmljZSA+PSAwKQorCQli
aWFzICs9IHAtPnN0YXRpY19wcmlvIC0gcC0+cHJpbyArIG5pY2UgLSBJTlRFUkFDVElWRV9ERUxU
QTsKKwlpZiAoYmlhcyA8PSAwKQorCQliaWFzID0gMTsKKwlpZiAocC0+c2xlZXBfYXZnID49IGJp
YXMpCisJCXAtPnNsZWVwX2F2ZyAtPSBiaWFzOworfQogCiAvKgogICogVGhpcyBmdW5jdGlvbiBn
ZXRzIGNhbGxlZCBieSB0aGUgdGltZXIgY29kZSwgd2l0aCBIWiBmcmVxdWVuY3kuCkBAIC0xMjAz
LDEyICsxMjQzLDEzIEBACiAJCWtzdGF0X2NwdShjcHUpLmNwdXN0YXQudXNlciArPSB1c2VyX3Rp
Y2tzOwogCWtzdGF0X2NwdShjcHUpLmNwdXN0YXQuc3lzdGVtICs9IHN5c190aWNrczsKIAorCXNw
aW5fbG9jaygmcnEtPmxvY2spOwogCS8qIFRhc2sgbWlnaHQgaGF2ZSBleHBpcmVkIGFscmVhZHks
IGJ1dCBub3Qgc2NoZWR1bGVkIG9mZiB5ZXQgKi8KLQlpZiAocC0+YXJyYXkgIT0gcnEtPmFjdGl2
ZSkgewotCQlzZXRfdHNrX25lZWRfcmVzY2hlZChwKTsKLQkJcmV0dXJuOworCWlmIChwLT5hcnJh
eSAhPSBycS0+YWN0aXZlIHx8IHAtPnN0YXRlICE9IFRBU0tfUlVOTklORykgeworCQlpZiAocC0+
c3RhdGUgPiBUQVNLX1VOSU5URVJSVVBUSUJMRSkKKwkJCXNldF90c2tfbmVlZF9yZXNjaGVkKHAp
OworCQlnb3RvIG91dDsKIAl9Ci0Jc3Bpbl9sb2NrKCZycS0+bG9jayk7CiAJLyoKIAkgKiBUaGUg
dGFzayB3YXMgcnVubmluZyBkdXJpbmcgdGhpcyB0aWNrIC0gdXBkYXRlIHRoZQogCSAqIHRpbWUg
c2xpY2UgY291bnRlciBhbmQgdGhlIHNsZWVwIGF2ZXJhZ2UuIE5vdGU6IHdlCkBAIC0xMjE3LDgg
KzEyNTgsNiBAQAogCSAqIGl0IHBvc3NpYmxlIGZvciBpbnRlcmFjdGl2ZSB0YXNrcyB0byB1c2Ug
dXAgdGhlaXIKIAkgKiB0aW1lc2xpY2VzIGF0IHRoZWlyIGhpZ2hlc3QgcHJpb3JpdHkgbGV2ZWxz
LgogCSAqLwotCWlmIChwLT5zbGVlcF9hdmcpCi0JCXAtPnNsZWVwX2F2Zy0tOwogCWlmICh1bmxp
a2VseShydF90YXNrKHApKSkgewogCQkvKgogCQkgKiBSUiB0YXNrcyBuZWVkIGEgc3BlY2lhbCBm
b3JtIG9mIHRpbWVzbGljZSBtYW5hZ2VtZW50LgpAQCAtMTIzNSw2ICsxMjc0LDcgQEAKIAkJfQog
CQlnb3RvIG91dDsKIAl9CisJc2xlZXBfYXZnX3RpY2socCk7CiAJaWYgKCEtLXAtPnRpbWVfc2xp
Y2UpIHsKIAkJZGVxdWV1ZV90YXNrKHAsIHJxLT5hY3RpdmUpOwogCQlzZXRfdHNrX25lZWRfcmVz
Y2hlZChwKTsKQEAgLTEyNDgsNiArMTI4OCwyNiBAQAogCQkJZW5xdWV1ZV90YXNrKHAsIHJxLT5l
eHBpcmVkKTsKIAkJfSBlbHNlCiAJCQllbnF1ZXVlX3Rhc2socCwgcnEtPmFjdGl2ZSk7CisJCWdv
dG8gb3V0OworCX0KKwkvKgorCSAqIFByZXZlbnQgYSB0b28gbG9uZyB0aW1lc2xpY2UgYWxsb3dp
bmcgYSB0YXNrIHRvIG1vbm9wb2xpemUKKwkgKiB0aGUgQ1BVLiBXZSBkbyB0aGlzIGJ5IHNwbGl0
dGluZyB1cCB0aGUgdGltZXNsaWNlIGludG8KKwkgKiBzbWFsbGVyIHBpZWNlcy4KKwkgKgorCSAq
IE5vdGU6IHRoaXMgZG9lcyBub3QgbWVhbiB0aGUgdGFzaydzIHRpbWVzbGljZXMgZXhwaXJlIG9y
CisJICogZ2V0IGxvc3QgaW4gYW55IHdheSwgdGhleSBqdXN0IG1pZ2h0IGJlIHByZWVtcHRlZCBi
eQorCSAqIGFub3RoZXIgdGFzayBvZiBlcXVhbCBwcmlvcml0eS4gKG9uZSB3aXRoIGhpZ2hlcgor
CSAqIHByaW9yaXR5IHdvdWxkIGhhdmUgcHJlZW1wdGVkIHRoaXMgdGFzayBhbHJlYWR5LikgV2UK
KwkgKiByZXF1ZXVlIHRoaXMgdGFzayB0byB0aGUgZW5kIG9mIHRoZSBsaXN0IG9uIHRoaXMgcHJp
b3JpdHkKKwkgKiBsZXZlbCwgd2hpY2ggaXMgaW4gZXNzZW5jZSBhIHJvdW5kLXJvYmluIG9mIHRh
c2tzIHdpdGgKKwkgKiBlcXVhbCBwcmlvcml0eS4KKwkgKi8KKwlpZiAoIShwLT50aW1lX3NsaWNl
ICUgVElNRVNMSUNFX0dSQU5VTEFSSVRZKSkgeworCQlkZXF1ZXVlX3Rhc2socCwgcnEtPmFjdGl2
ZSk7CisJCXNldF90c2tfbmVlZF9yZXNjaGVkKHApOworCQlwLT5wcmlvID0gZWZmZWN0aXZlX3By
aW8ocCk7CisJCWVucXVldWVfdGFzayhwLCBycS0+YWN0aXZlKTsKIAl9CiBvdXQ6CiAJc3Bpbl91
bmxvY2soJnJxLT5sb2NrKTsKQEAgLTE2NjksNyArMTcyOSw3IEBACiAgKi8KIGludCB0YXNrX3By
aW8odGFza190ICpwKQogewotCXJldHVybiBwLT5wcmlvIC0gTUFYX1VTRVJfUlRfUFJJTzsKKwly
ZXR1cm4gcC0+cHJpbyAtIE1BWF9SVF9QUklPOwogfQogCiAvKioKQEAgLTI1MjUsNiArMjU4NSw3
IEBACiAJcnEgPSB0aGlzX3JxKCk7CiAJcnEtPmN1cnIgPSBjdXJyZW50OwogCXJxLT5pZGxlID0g
Y3VycmVudDsKKwljdXJyZW50LT5zbGVlcF9hdmcgPSBNQVhfU0xFRVBfQVZHOwogCXNldF90YXNr
X2NwdShjdXJyZW50LCBzbXBfcHJvY2Vzc29yX2lkKCkpOwogCXdha2VfdXBfZm9ya2VkX3Byb2Nl
c3MoY3VycmVudCk7CiAK
--=====================_38529750==_--

