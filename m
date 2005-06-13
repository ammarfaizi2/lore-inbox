Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVFMVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVFMVlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVFMVkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:40:23 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:45948 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261429AbVFMViZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:38:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=FmCFI6kQOgQrHaVrpiIGBQjVFbANAxjmd4AICdQimyTTTGQiZRcCrd4YrIMk8rW4fOA9EqgvnJV1oVFu582VwGju5OqZ+9L/u+DEPld/e06plqtyz/VYh1sB7VmcUd380lIvun+pp9WXG87SS1UhRR4texPuFwjEVaZGX10ub+s=
Message-ID: <9a8748490506131438923fbf3@mail.gmail.com>
Date: Mon, 13 Jun 2005 23:38:17 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Thomas Hood <jdthood@aglu.demon.nl>
Subject: Re: [FIX] apm.c: ignore_normal_resume is set to 1 a bit too late
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1118655939.7066.37.camel@thanatos>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5699_5786776.1118698697467"
References: <1118655939.7066.37.camel@thanatos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_5699_5786776.1118698697467
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 6/13/05, Thomas Hood <jdthood@aglu.demon.nl> wrote:
> This message contains a fix for a bug in the apm driver.
>=20
> A bug report was submitted to the Debian BTS saying that on the
> submitter's system the apmd proxy script was being run twice on resume.
>=20
> Having seen exactly the same problem some years ago and knowing that the
> solution then was to ensure that the ignore_normal_resume flag got set
> before there was any chance of an APM RESUME event being processed, I
> checked the current apm.c and I found that ignore_normal_resume was once
> again being set too late.  I asked the submitter to move the line where
> the flag was set and he reported that this change solved the problem.  I
> append the message in question.  The line numbers I mention there are
> for Linux 2.6.11.
>=20
> Please make the indicated change to the apm driver.
>=20
> -------- Forwarded Message --------
> jdthood@aglu.demon.nl wrote to the submitter of Debian bug #310865:
> > In arch/i386/kernel/apm.c there is at approximately line 1229:
> >
> >         ignore_normal_resume =3D 1;
> >
> > Move this up so that it occurs right after line 1222:
> >
> >         err =3D set_system_power_state(APM_STATE_SUSPEND);
> >
> > Let us know if that helps.
>=20
>=20
> It does. Very nice.
> I don't understand what I did and how it works. Will you try to
> push that into kernel sources or is this no permanent fix?
> --
> Thomas Hood <jdthood@aglu.demon.nl>
>=20

Here it is in the form of a patch against 2.6.12-rc6-mm1 for easier
merging - Stephen, Andrew, is this a valid fix? I don't know the apm
code well enough to properly judge.
(also attached since gmail tends to mangle inline patches)


Prevent double resume in apm.

Signed-off-by: Jesper juhl <jesper.juhl@gmail.com>
---

 arch/i386/kernel/apm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc6-mm1-orig/arch/i386/kernel/apm.c=092005-06-12
15:58:34.000000000 +0200
+++ linux-2.6.12-rc6-mm1/arch/i386/kernel/apm.c=092005-06-13
23:39:57.000000000 +0200
@@ -1222,6 +1222,7 @@ static int suspend(int vetoable)
=20
 =09save_processor_state();
 =09err =3D set_system_power_state(APM_STATE_SUSPEND);
+=09ignore_normal_resume =3D 1;
 =09restore_processor_state();
=20
 =09local_irq_disable();
@@ -1229,7 +1230,6 @@ static int suspend(int vetoable)
 =09spin_lock(&i8253_lock);
 =09reinit_timer();
 =09set_time();
-=09ignore_normal_resume =3D 1;
=20
 =09spin_unlock(&i8253_lock);
 =09write_sequnlock(&xtime_lock);



--=20
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_5699_5786776.1118698697467
Content-Type: text/x-patch; name="prevent-double-resume-in-apm.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="prevent-double-resume-in-apm.patch"

LS0tIGxpbnV4LTIuNi4xMi1yYzYtbW0xLW9yaWcvYXJjaC9pMzg2L2tlcm5lbC9hcG0uYwkyMDA1
LTA2LTEyIDE1OjU4OjM0LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjEyLXJjNi1tbTEv
YXJjaC9pMzg2L2tlcm5lbC9hcG0uYwkyMDA1LTA2LTEzIDIzOjM5OjU3LjAwMDAwMDAwMCArMDIw
MApAQCAtMTIyMiw2ICsxMjIyLDcgQEAgc3RhdGljIGludCBzdXNwZW5kKGludCB2ZXRvYWJsZSkK
IAogCXNhdmVfcHJvY2Vzc29yX3N0YXRlKCk7CiAJZXJyID0gc2V0X3N5c3RlbV9wb3dlcl9zdGF0
ZShBUE1fU1RBVEVfU1VTUEVORCk7CisJaWdub3JlX25vcm1hbF9yZXN1bWUgPSAxOwogCXJlc3Rv
cmVfcHJvY2Vzc29yX3N0YXRlKCk7CiAKIAlsb2NhbF9pcnFfZGlzYWJsZSgpOwpAQCAtMTIyOSw3
ICsxMjMwLDYgQEAgc3RhdGljIGludCBzdXNwZW5kKGludCB2ZXRvYWJsZSkKIAlzcGluX2xvY2so
Jmk4MjUzX2xvY2spOwogCXJlaW5pdF90aW1lcigpOwogCXNldF90aW1lKCk7Ci0JaWdub3JlX25v
cm1hbF9yZXN1bWUgPSAxOwogCiAJc3Bpbl91bmxvY2soJmk4MjUzX2xvY2spOwogCXdyaXRlX3Nl
cXVubG9jaygmeHRpbWVfbG9jayk7Cg==
------=_Part_5699_5786776.1118698697467--
