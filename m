Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274080AbRIXRkh>; Mon, 24 Sep 2001 13:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274082AbRIXRk2>; Mon, 24 Sep 2001 13:40:28 -0400
Received: from codepoet.org ([166.70.14.212]:47937 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S274080AbRIXRkM>;
	Mon, 24 Sep 2001 13:40:12 -0400
Date: Mon, 24 Sep 2001 11:40:37 -0600
From: Erik Andersen <andersen@codepoet.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
Message-ID: <20010924114037.A7561@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010924002854.A25226@codepoet.org> <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <16995.1001284442@redhat.com> <32737.1001314127@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32737.1001314127@redhat.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 24, 2001 at 07:48:47AM +0100, David Woodhouse wrote:
> 
> andersen@codepoet.org said:
> > Is jffs2 still showing the
> >     Child dir "." (ino #1) of dir ino #1 appears to be a hard link
> > problem?  I saw you patched mkfs.jffs2 after my changes -- do you
> > still need me to hunt down that bug I added? 
> 
> Yes please. The patch I committed just made it happier with a relative (or
> no) root directory - it was changing into the specified directory and then
> still prepending its name to every path. I assume it's still emitting a
> dirent for '.' in the root directory as it was before. The JFFS2 kernel code
> doesn't like that very much.

This seems to fix it, but I'm not certain this is correct?
Should / on jffs2 have neither inode nor dirent added?

--- mkfs.jffs2.c	2001/09/17 13:43:32	1.16
+++ mkfs.jffs2.c	2001/09/24 17:37:40
@@ -924,10 +924,11 @@
 		name = tmp_dir->name;
 		sb = tmp_dir->sb;
 		if (!tmp_dir->parent) {
+			/* Cope with the root directory */
 			ino = highest_ino++;
-			debug_msg("writing '/' ino=%lu", (unsigned long) ino);
-			output_pipe(ino, &sb);
-			write_dirent(ino, version++, ino, timestamp, DT_DIR, name);
+			debug_msg("writing '%s' ino=%lu", name, (unsigned long) ino);
+			//output_pipe(ino, &sb);
+			//write_dirent(ino, version++, ino, timestamp, DT_DIR, name);
 			tmp_dir = tmp_dir->next;
 			continue;
 		}

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
