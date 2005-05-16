Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVEPGGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVEPGGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 02:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVEPGGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 02:06:00 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:38413 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261324AbVEPGFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 02:05:44 -0400
Subject: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116263665.2434.69.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 May 2005 13:14:25 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, ML subscribers,
    
    I'm taking part in the project DOUBT[1], and my sub-project
focuses on the consistency and coherency of FS[2].
    There is something I'm still confused - What error should FS
return when I/O failure occurs? It seems there are no relevant 
documents or standards on this issue.
    
    I'll just show some examples to make things clear:
1. For EXT3 partition , we mount it as RW, but when I/O occurs, the
   I/O related functions return EROFS(ReadOnly?), while other FSes
   return EIO.
2. Assume a program doing the following: open - write(async) - close
   When user-mode app calls sys_write, for EXT2/JFS, no error 
   returns, for EXT3, EROFS returns, for XFS/ReiserFS, EIO returns.

I know each FS has its own implementation, but from users'
perspective, they don't care what FS they're using. So, when 
handling errors from syscall, they can't do the following(p-code):
  ret = sys_write(fd, buf, size);
  if(ret < 0){
     /* the following is I/O failure related. */
     if((IsEXT3() && errno == EROFS) || 
        ((IsXFS() || IsReiserFS()) && errno == EIO)){
        /* do some things about I/O failure */
        ....
     }else{
        ....
     }
   } 
When I/O failure occurs, there should be some standards which 
define the ONLY error that should be returned from VFS, right?
What they should do is (p-code):
  ret = sys_write(fd, buf, size);
  if(ret < 0){
     if(errno == EIO){
        ...
     }else
        ...
  } 
   

Ref
[1]http://developer.osdl.jp/projects/doubt/
[2]http://developer.osdl.jp/projects/doubt/fs-consistency-and-coherency/index.html

regards,
----
Qu Fuping


