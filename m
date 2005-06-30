Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVF3PvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVF3PvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVF3PvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:51:02 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:57787 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262920AbVF3PuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:50:09 -0400
Subject: Re: [PATCH 0/6] Integrate AIO with wait-bit based filtered wakeups
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "suparna@in.ibm.com" <suparna@in.ibm.com>
Cc: "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Benjamin LaHaise <bcrl@kvack.org>, wli@holomorphy.com, zab@zabbo.net,
       mason@suse.com
In-Reply-To: <20050620160126.GA5271@in.ibm.com>
References: <20050620120154.GA4810@in.ibm.com>
	 <20050620160126.GA5271@in.ibm.com>
Date: Thu, 30 Jun 2005 17:49:00 +0200
Message-Id: <1120146540.1604.65.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/06/2005 18:01:35,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/06/2005 18:01:36
Content-Type: multipart/mixed; boundary="=-zqpVODo48voPQcNuY/op"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zqpVODo48voPQcNuY/op
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

On Mon, 2005-06-20 at 21:31 +0530, Suparna Bhattacharya wrote:
> On Mon, Jun 20, 2005 at 05:31:54PM +0530, Suparna Bhattacharya wrote:
> > Since AIO development is gaining momentum once again, ocfs2 and
> > samba both appear to be using AIO, NFS needs async semaphores etc,
> > there appears to be an increase in interest in straightening out some
> > of the pending work in this area. So this seems like a good
> > time to re-post some of those patches for discussion and decision.
> >=20
> > Just to help sync up, here is an initial list based on the pieces
> > that have been in progress with patches in existence (please feel free
> > to add/update ones I missed or reflected inaccurately here):
> >=20
> > (1) Updating AIO to use wait-bit based filtered wakeups (me/wli)
> > 	Status: Updated to 2.6.12-rc6, needs review
>=20
> Here is a little bit of background on the motivation behind this set of
> patches to update AIO for filtered wakeups:
>=20
> (a) Since the introduction of filtered wakeups support and=20
>     the wait_bit_queue infrastructure in mainline, it is no longer
>     sufficient to just embed a wait queue entry in the kiocb
>     for AIO operations involving filtered wakeups.
> (b) Given that filesystem reads/writes use filtered wakeups underlying
>     wait_on_page_bit, fixing this becomes a pre-req for buffered
>     filesystem AIO.
> (c) The wait_bit_queue infrastructure actually enables a cleaner
>     implementation of filesystem AIO because it already provides
>     for an action routine intended to allow both blocking and
>     non-blocking or asynchronous behaviour.
>=20
> As I was rewriting the patches to address this, there is one other
> change I made to resolve one remaining ugliness in my earlier
> patchsets - special casing of the form=20
> 	if (wait =3D=3D NULL) wait =3D &local_wait
> to switch to a stack based wait queue entry if not passed a wait
> queue entry associated with an iocb.
>=20
> To avoid this, I have tried biting the bullet by including a default
> wait bit queue entry in the task structure, to be used instead of
> on-demand allocation of a wait bit queue entry on stack.
>=20
> All in all, these changes have (hopefully) simplified the code,
> as well as made it more up-to-date. Comments (including
> better names etc as requested by Zach) are welcome !
>=20
> Regards
> Suparna
>=20

  Just found a bug in aio_run_iocb: after having called the retry
method for the iocb, current->io_wait is RESET to NULL. While this
does not affect applications doing only AIO, applications
mixing sync and async IO (MySQL for example) end up crashing
later on in the sync path when calling lock_page_slow as the io_wait
queue is NULL.

  Therefore after the retry method has been called the task io_wait
queue should be set to the default queue.

  This patch applies over Suparna's wait-bit patchset and maybe should=20
be folded into aio-wait-bit.

  S=E9bastien.

--=20
------------------------------------------------------

  S=E9bastien Dugu=E9                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
 =20
------------------------------------------------------

--=-zqpVODo48voPQcNuY/op
Content-Disposition: attachment; filename=aio-retry-iowait-fix
Content-Type: application/octet-stream; name=aio-retry-iowait-fix
Content-Transfer-Encoding: base64

CiAgV2hlbiBhbiBhcHBsaWNhdGlvbiBpcyBtaXhpbmcgc3luYyBhbmQgYXN5bmMgSU8gaXQgZW5k
cyB1cCBjcmFzaGluZwpsYXRlciBvbiBpbiB0aGUgc3luYyBwYXRoIHdoZW4gY2FsbGluZyBsb2Nr
X3BhZ2Vfc2xvdyBhcyB0aGUgaW9fd2FpdApxdWV1ZSBoYXMgYmVlbiBzZXQgdG8gTlVMTCBpbiBh
IHByZXZpb3VzIEFJTyByZXF1ZXN0LgoKICBUaGVyZWZvcmUgYWZ0ZXIgdGhlIHJldHJ5IG1ldGhv
ZCBoYXMgYmVlbiBjYWxsZWQgdGhlIHRhc2sgaW9fd2FpdApxdWV1ZSBzaG91bGQgYmUgc2V0IHRv
IHRoZSBkZWZhdWx0IHF1ZXVlLgoKICBUaGlzIHBhdGNoIGFwcGxpZXMgb3ZlciBTdXBhcm5hJ3Mg
d2FpdC1iaXQgcGF0Y2hzZXQ6CgoJLSBtb2RpZnktd2FpdC1iaXQtYWN0aW9uLWFyZ3MKCS0gbG9j
a19wYWdlX3dhaXQKCS0gaW5pdC13YWl0LWJpdC1rZXkKCS0gdHNrLWRlZmF1bHQtaW8td2FpdAoJ
LSBhaW8td2FpdC1iaXQKCS0gYWlvLXdhaXQtcGFnZQoKYW5kIGNvdWxkIGJlIGZvbGRlZCBpbnRv
IGFpby13YWl0LWJpdC4KClNpZ25lZC1vZmYtYnk6IFPpYmFzdGllbiBEdWd16SA8c2ViYXN0aWVu
LmR1Z3VlQGJ1bGwubmV0PgoKCiBhaW8uYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51eC0yLjYuMTIvZnMvYWlvLmMK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQotLS0gbGludXgtMi42LjEyLm9yaWcvZnMvYWlvLmMJMjAwNS0wNi0zMCAxNzo0
ODo0Ny4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xMi9mcy9haW8uYwkyMDA1LTA2LTMw
IDE3OjQ4OjU3LjAwMDAwMDAwMCArMDIwMApAQCAtNzE0LDcgKzcxNCw3IEBACiAJQlVHX09OKCFp
c19zeW5jX3dhaXQoY3VycmVudC0+aW9fd2FpdCkpOwogCWN1cnJlbnQtPmlvX3dhaXQgPSAmaW9j
Yi0+a2lfd2FpdC53YWl0OwogCXJldCA9IHJldHJ5KGlvY2IpOwotCWN1cnJlbnQtPmlvX3dhaXQg
PSBOVUxMOworCWN1cnJlbnQtPmlvX3dhaXQgPSAmY3VycmVudC0+X193YWl0LndhaXQ7CiAKIAlp
ZiAoLUVJT0NCUkVUUlkgIT0gcmV0KSB7CiAgCQlpZiAoLUVJT0NCUVVFVUVEICE9IHJldCkgewo=

--=-zqpVODo48voPQcNuY/op--

