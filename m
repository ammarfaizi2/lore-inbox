Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWBRRMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWBRRMs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWBRRMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:12:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:63886 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932084AbWBRRMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:12:48 -0500
X-Authenticated: #5039886
Date: Sat, 18 Feb 2006 18:12:43 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: herbert@13thfloor.at, akpm@osdl.org, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, torvalds@osdl.org
Subject: Re: kjournald keeps reference to namespace
Message-ID: <20060218171243.GA23640@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	herbert@13thfloor.at, akpm@osdl.org, viro@ftp.linux.org.uk,
	linux-kernel@vger.kernel.org, ebiederm@xmission.com,
	torvalds@osdl.org
References: <20060218013547.GA32706@MAIL.13thfloor.at> <20060218133647.GA9332@atjola.homenet> <20060218163227.GA23344@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060218163227.GA23344@atjola.homenet>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.02.18 17:32:27 +0100, Björn Steinbrink wrote:
> > In daemonize() a new thread gets cleaned up and 'merged' with init_task.
> > The current fs_struct is handled there, but not the current namespace.
> > The following patch adds the namespace part.
> > 
> > Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
> > ---
> 
> Oops, forgot the increment the namespace usage count...

Ok, this time with the get_namespace wrapper, thanks to Eric Biederman
for pointing that out to me.
---


diff -NurpP --minimal linux-2.6.16-rc4/kernel/exit.c linux-2.6.16-rc4-ns/kernel/exit.c
--- linux-2.6.16-rc4/kernel/exit.c	2006-02-18 13:59:59.000000000 +0100
+++ linux-2.6.16-rc4-ns/kernel/exit.c	2006-02-18 17:57:21.000000000 +0100
@@ -360,6 +360,9 @@ void daemonize(const char *name, ...)
 	fs = init_task.fs;
 	current->fs = fs;
 	atomic_inc(&fs->count);
+	exit_namespace(current);
+	current->namespace = init_task.namespace;
+	get_namespace(current->namespace);
  	exit_files(current);
 	current->files = init_task.files;
 	atomic_inc(&current->files->count);
