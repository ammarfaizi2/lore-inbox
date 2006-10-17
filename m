Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWJQSBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWJQSBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWJQSBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:01:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:49311 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750724AbWJQSBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:01:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=W/VC8rI686NPKDEwI62DpinmYtFBIrmFr600rEG0pHB7ITiVqwH4oc5NP0M87rStHC043jjXB1zNtzbCUJoegU+aufoeMVOUeLh52QZKauBr2xz2bKrWdSH+eOriP1DlZwvnBKICe7kP5VXlr1FtKwk4BG3DiqXA/Ep5ezsasIY=
Date: Tue, 17 Oct 2006 20:02:10 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ismail Donmez <ismail@pardus.org.tr>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <20061017180210.GA20287@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610172041.42873.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ismail Donmez <ismail@pardus.org.tr> ha scritto:
>>
>> while working on better ISO-9660 support for the Solaris Kernel,
>> I recently enhanced mkisofs to support the Rock Ridge Standard version 1.12
>> from 1994.
>>
>> The difference bewteen version 1.12 and 1.10 (this is what previous
>> mkisofs versions did implement) is that the "PX" field is now 8 Byte
>> bigger than before (44 instead of 36 bytes).
> 
> Is there a test iso file somewhere? I think the attached *untested* patch will 
> fix it.

I was also looking at this ;) I cannot reproduce the failure even with
images generated with the new version of mkisofs (I actually _see_ that
PX record size is changed, but isofs doesn't seem to care...).

> diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> index f3a1db3..061a633 100644
> --- a/fs/isofs/rock.c
> +++ b/fs/isofs/rock.c
> @@ -349,6 +349,7 @@ #endif
>                         inode->i_nlink = isonum_733(rr->u.PX.n_links);
>                         inode->i_uid = isonum_733(rr->u.PX.uid);
>                         inode->i_gid = isonum_733(rr->u.PX.gid);
> +                       inode->i_ino = isonum_733(rr->u.PX.ino);
>                         break;

I don't think it's correct. When reading disk with old format i_ino will
be filled with garbage.
Now, who is in charge of isofs?

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

---
 fs/isofs/rock.c |    4 ++++
 fs/isofs/rock.h |    1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index f3a1db3..9a87010 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -349,6 +349,10 @@ #endif
 			inode->i_nlink = isonum_733(rr->u.PX.n_links);
 			inode->i_uid = isonum_733(rr->u.PX.uid);
 			inode->i_gid = isonum_733(rr->u.PX.gid);
+			
+			/* Rock Ridge V1.12, override inode number */
+			if (rr->len == 44)
+				inode->i_ino = isonum_733(rr->u.PX.inode);
 			break;
 		case SIG('P', 'N'):
 			{
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index ed09e2b..df5f2a7 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -33,6 +33,7 @@ struct RR_PX_s {
 	char n_links[8];
 	char uid[8];
 	char gid[8];
+	char inode[8];
 };
 
 struct RR_PN_s {


Luca
-- 
Sbagliare è umano, ma per incasinare davvero le cose serve un computer.
