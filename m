Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSG2LOY>; Mon, 29 Jul 2002 07:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSG2LOY>; Mon, 29 Jul 2002 07:14:24 -0400
Received: from [62.40.73.125] ([62.40.73.125]:20713 "HELO Router")
	by vger.kernel.org with SMTP id <S315276AbSG2LOX>;
	Mon, 29 Jul 2002 07:14:23 -0400
Date: Sun, 28 Jul 2002 18:52:56 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-fsdevel@vger.kerner.org, linux-kernel@vger.kernel.org
Subject: Race in open(O_CREAT|O_EXCL) and network filesystem
Message-ID: <20020728165256.GA4631@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-fsdevel@vger.kerner.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

maybe I'm blind, but I think there is a race featuring
open(O_CREAT|O_EXCL) and nfs or any other network fs.

What may happen is:

client A: open_namei looks up the inode
	driver queries server and gets ENOENT
client B: open_namei looks up the inode
	driver queries server and gets ENOENT
client A: open_namei calls create method
	driver requests file to be created and is successful
client B: open_namei calls create method
	dirver requests file to be created and since it does not know,
	cant specify exclusion, thus is succesful
client A: open_namei does no more checks and thus open succeeds
client B: open succeeds too here - and it shouldn't

Since many applications rely on this working correctly (especialy
mailboxes are locked using exclusive creates and mounting them over NFS
is quite common).

So, can someone please answer:

1) Is there some reason this can't happen that I overlooked?
2) If it is a problem (comment in NFS suggest so), I can see two ways of
handling this. Either pass the flags to the create method, or restart
the open when create returns EEXISTS. Which one would be prefered?
3) How to fix NFS to add exclude flag to the NFSv3 request?

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
