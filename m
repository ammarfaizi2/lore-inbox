Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbTGKS7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTGKS6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:58:40 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:29963 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264897AbTGKSdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:33:22 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: devfs@oss.sgi.com
Subject: devfsd hangs on restart - is_devfsd_or_child() problem
Date: Fri, 11 Jul 2003 22:47:12 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Thierry Vignaud <tvignaud@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307112247.12646.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot believe it is so fragile ...

is_devfsd_or_child() simplemindedly checks for pgrp:

static int is_devfsd_or_child (struct fs_info *fs_info)
{
    if (current == fs_info->devfsd_task) return (TRUE);
    if (current->pgrp == fs_info->devfsd_pgrp) return (TRUE);
    return (FALSE);
}   /*  End Function is_devfsd_or_child  */

unfortunately, bash (I do not know if it does it always or not) resets pgrp on 
startup. I.e. if your action is using shell it is no more considered devfsd 
descendant ... and it will attempt in turn start devfsd action while devfsd 
is waiting for it ot finish.

Thierry, i refer mostly to dynamics scripts currently. Every time I update 
devfsd it hangs in one of them. And actually it is enough to do service 
devfsd restart to trigger this. It may be 2.5 specific again in that it is 
not as easily seen under 2.4.

I have no idea what can be done. Is there any way in kernel to find out if one 
task is descendant of other task? Even rewriting devfsd to use non-blocking 
calls and request queue does not help as it apprently just results in endless 
loop (action triggering action triggering action ...)

-andrey
