Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVCTAWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVCTAWq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 19:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVCTAWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 19:22:45 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:9390 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261929AbVCTAWn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 19:22:43 -0500
Cc: albert@users.sf.net, akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       pj@engr.sgi.com, 7eggert@gmx.de
Subject: [PATCH][0/6] Change proc file permissions with sysctls
In-Reply-To: 
Date: Sun, 20 Mar 2005 01:22:42 +0100
Message-Id: <1111278162.22BA.5209@neapel230.server4you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches implement another interface that allows an admin
to restrict permissions inside /proc/<pid> to enhance the privacy of
users.  Following a suggestion by Albert Calahan this set of patches
introduces five sysctls, each one changes the permissions of a certain
file in /proc/<pid>.

It works by implementing getattr and permission methods that update the
files' permissions (btw. Al Viro suggested doing it this way right from
the start..).

To "cloak" as much as currently possible:

   # sysctl -q proc.cmdline=0400
   # sysctl -q proc.maps=0400
   # sysctl -q proc.stat=0400
   # sysctl -q proc.statm=0400
   # sysctl -q proc.status=0400

This will set the permissions of /proc/*/cmdline etc. to the given
value.

The permissions of files in /proc/1 (usually belonging to init) are
kept as they are.  The idea is to let system processes be freely
visible by anyone, just as before.  Especially interesting in this
regard would be instances of login.  I don't know how to easily
discriminate between system processes and "normal" processes inside
the kernel (apart from pid == 1 and uid == 0 (which is too broad)).
Any ideas?

It's easy to make more files' permissions configurable, if the need
arises.

This implementation is a lot bigger than the quick hacks I sent earlier.
Is this feature growing too fat?  Also I'm unsure about the #ifdef'ery
in fs/proc/base.c, I just wanted to be consistent with the surrounding
code. :-P

Rene

