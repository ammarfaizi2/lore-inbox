Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUJGTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUJGTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267901AbUJGTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:17:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:63952 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267860AbUJGTQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:16:52 -0400
Message-Id: <200410071916.i97JGmft018659@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c 
In-Reply-To: Your message of "Thu, 07 Oct 2004 12:01:19 PDT."
             <4165927F.5040606@intel.com> 
From: Valdis.Kletnieks@vt.edu
References: <4164756E.4010408@intel.com> <200410071811.i97IBQf0031262@turing-police.cc.vt.edu> <41658FB4.5090402@intel.com> <200410071854.i97IsvU5031703@turing-police.cc.vt.edu>
            <4165927F.5040606@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_66732640P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 15:16:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_66732640P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <2731.1097176607.1@turing-police.cc.vt.edu>

On Thu, 07 Oct 2004 12:01:19 PDT, Arun Sharma said:

> Many callers in binfmt_elf.c are passing pointers that are kernel addresses.
> But file_operations->write() is expecting a __user pointer. The intention of
> the cast is to explicitly say that's an okay thing to do.

Right.  My point was that if you're fixing the warning, you should do the
*whole* job by making sure that what *you* got in that 'void *' is a __user
pointer, rather than just saying "we know write() wants a __user".

So for instance, up a level in writenote():

#define DUMP_WRITE(addr, nr)            do { if (!dump_write(file, (addr), (nr))) return 0; } while(0)
#define DUMP_SEEK(off)          do { if (!dump_seek(file, (off))) return 0; } while(0)

static int writenote(struct memelfnote *men, struct file *file)
{
        struct elf_note en;

        en.n_namesz = strlen(men->name) + 1;
        en.n_descsz = men->datasz;
        en.n_type = men->type;

        DUMP_WRITE(&en, sizeof(en));
        DUMP_WRITE(men->name, en.n_namesz);

Is men->name a __user pointer?  Should it be? Can it be something else?

struct memelfnote
{
        const char *name;
        int type;
        unsigned int datasz;
        void *data;
};

Hmm.. there it's a 'const char *name', but we feed it to a 'const void *'
and then you cast it to a __user.  Either that *name should be __user
as well, or you tagged something as a __user that might not be.

*That*s what I'm talking about....


--==_Exmh_66732640P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZZYgcC3lWbTT17ARAv2oAJ4+mXsRgL8Ty7Sqsy/X0UWN15sJ2ACgq1Vu
FFQ0iRB+4Fz1eYimOavBRhU=
=ViNQ
-----END PGP SIGNATURE-----

--==_Exmh_66732640P--
