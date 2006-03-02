Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWCBCqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWCBCqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCBCqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:46:44 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:43832 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750972AbWCBCqn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:46:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S37tkBZjD3MkViPnkKZKcEx2ZAqkEfX8WpNThJRH1rN59RwKwakI+EFzTlGbHyAkNxTzm5LlZw+ueFYGNntpswU93CxKKiPz0OreaWGukeGz4/cl+QFyDc2P5GQDZhh+yeUR5tdtPKDs/Kff44n3pRbjo8np1D0LrWo0EVZlYcQ=
Message-ID: <bda6d13a0603011846s6bfed498ha9fb78c4ba74963c@mail.gmail.com>
Date: Wed, 1 Mar 2006 18:46:42 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Possible deadlock in vfs layer, namei.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been hunting down various deadlocks caused by hard links to directories.
I found one that can happen *without* such things.

Consider this:

17 3 drwxr-xr-x root sys 4096 dir
18 2 drwxr-xr-x root sys 4096 dir/subdir
19 1 -rwxr-xr-x root sys 1733 dir/subdir/file

process 1 does: rename("dir/subdir/file", "dir/file")
process 2 does: rmdir("dir/subdir")

from namei.c (function: lock_rename), rename takes:
1. s_vfs_rename_sem,
2. dir/subdir: p1->d_inode->i_sem
3. dir: p2->d_inode->i_sem

rmdir takes (multiple functions):
1. dir  (sys_rename)
2. dir/subdir (vfs_rename)

Suppose this happends:
[proc 1] s_vfs_rename_sem
[proc 1] dir/subdir
*task switch*
[proc 2] dir
[proc 2] dir/subdir ->deadlock

preempt_disable() won't help here. Could also be triggered on a SMP
machine w/o preempt.
Am studying situation, doesn't look promising.
