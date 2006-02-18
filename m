Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWBRQcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWBRQcb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWBRQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:32:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:29876 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750801AbWBRQca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:32:30 -0500
X-Authenticated: #5039886
Date: Sat, 18 Feb 2006 17:32:27 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: herbert@13thfloor.at, akpm@osdl.org, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: kjournald keeps reference to namespace
Message-ID: <20060218163227.GA23344@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	herbert@13thfloor.at, akpm@osdl.org, viro@ftp.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20060218013547.GA32706@MAIL.13thfloor.at> <20060218133647.GA9332@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060218133647.GA9332@atjola.homenet>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In daemonize() a new thread gets cleaned up and 'merged' with init_task.
> The current fs_struct is handled there, but not the current namespace.
> The following patch adds the namespace part.
> 
> Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
> ---

Oops, forgot the increment the namespace usage count...
---


diff -NurpP --minimal linux-2.6.16-rc4/kernel/exit.c linux-2.6.16-rc4-ns/kernel/exit.c
--- linux-2.6.16-rc4/kernel/exit.c	2006-02-18 13:59:59.000000000 +0100
+++ linux-2.6.16-rc4-ns/kernel/exit.c	2006-02-18 17:27:48.000000000 +0100
@@ -360,6 +360,9 @@ void daemonize(const char *name, ...)
 	fs = init_task.fs;
 	current->fs = fs;
 	atomic_inc(&fs->count);
+	exit_namespace(current);
+	current->namespace = init_task.namespace;
+	atomic_inc(&current->namespace->count);
  	exit_files(current);
 	current->files = init_task.files;
 	atomic_inc(&current->files->count);
