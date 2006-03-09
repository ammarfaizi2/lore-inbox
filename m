Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWCIE1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWCIE1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWCIE1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:27:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932251AbWCIE1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:27:52 -0500
Date: Wed, 8 Mar 2006 23:27:44 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: filldir[64] oddness
Message-ID: <20060309042744.GA23148@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm puzzled by an aparent use of uninitialised memory
that coverity's checker picked up.

fs/readdir.c

#define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
#define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))

140  	static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
141  			   ino_t ino, unsigned int d_type)
142  	{
143  		struct linux_dirent __user * dirent;
144  		struct getdents_callback * buf = (struct getdents_callback *) __buf
145  		int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);

How come that NAME_OFFSET isn't causing an oops when
it dereferences stackjunk->d_name ?

		Dave

-- 
http://www.codemonkey.org.uk
