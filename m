Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVISR5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVISR5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 13:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVISR5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 13:57:01 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:2238 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S932526AbVISR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 13:57:00 -0400
Message-ID: <432EFAB1.4080406@austin.rr.com>
Date: Mon, 19 Sep 2005 12:51:45 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
Subject: ctime set by truncate even if NOCMTIME requested
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing requests to set ctime on truncate which does not make any 
sense to me as I was testing with the flag that should have turned that 
off.  ie my inodes having S_NOCMTIME set, as NFS does.

do_truncate (line 206 of open.c) sets
      newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME
instead of
       newattrs.ia_valid = ATTR_SIZE;
      if(!IS_NOCMTIME(inode))
           newattrs.ia_valid |= ATTR_CTIME;

I thought that the correct way to handle this for network filesystems, 
is to let the server set the mtime and ctime unless the application 
explicitly sets the attributes (in the case of the sys call truncate or 
ftruncate the application is not explicitly setting the ctime/mtime as 
it would on a backup/restore so they should be ignored for the network 
fs so the server will set it correctl to its time, reducing traffic and 
more accurately representing the time it got updated).

Shouldn't there be a IS_NOCMTIME check in the truncate path in fs/open.c?
