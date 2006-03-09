Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbWCIEiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbWCIEiE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWCIEiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:38:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:10723 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932675AbWCIEiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:38:03 -0500
Date: Thu, 9 Mar 2006 04:38:02 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: filldir[64] oddness
Message-ID: <20060309043802.GR27946@ftp.linux.org.uk>
References: <20060309042744.GA23148@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309042744.GA23148@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:27:44PM -0500, Dave Jones wrote:
> I'm puzzled by an aparent use of uninitialised memory
> that coverity's checker picked up.
> 
> fs/readdir.c
> 
> #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
> #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
> 
> 140  	static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
> 141  			   ino_t ino, unsigned int d_type)
> 142  	{
> 143  		struct linux_dirent __user * dirent;
> 144  		struct getdents_callback * buf = (struct getdents_callback *) __buf
> 145  		int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
> 
> How come that NAME_OFFSET isn't causing an oops when
> it dereferences stackjunk->d_name ?

It doesn't dereference it.  d_name is an array, not a pointer.  FWIW,
it should've been

#define NAME_OFFSET(de) offsetof(typeof(de), d_name)

or, better yet

#define NAME_OFFSET offsetof(struct linux_dirent, d_name)
#define NAME_OFFSET64 offsetof(struct linux_dirent64, d_name)
