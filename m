Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTJJIkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTJJIkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:40:16 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:12169 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262709AbTJJIkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:40:08 -0400
To: linux-kernel@vger.kernel.org
Subject: net/sunrpc/clnt.c compilation error: tk_pid field
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 10 Oct 2003 17:40:00 +0900
Message-ID: <buo65ixv63j.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With linux-2.6.0-test7, I get compilation errors like:

     CC      net/sunrpc/clnt.o
   net/sunrpc/clnt.c:965: structure has no member named `tk_pid'
   net/sunrpc/clnt.c:970: structure has no member named `tk_pid'
   net/sunrpc/clnt.c:976: structure has no member named `tk_pid'
   make[2]: *** [net/sunrpc/clnt.o] Error 1

The reason seems to be that the tk_pid field is only included in
`struct rpc_task' (defined in include/linux/sunrpc/sched.h) if
DEBUG_RPC is defined, and DEBUG_RPC is only defined if CONFIG_SYSCTL
is defined (include/linux/sunrpc/debug.h).  I've enabled NFS, but not
CONFIG_SYSCTL:

   $ egrep '(SYSCTL|NFS|RPC)' .config
   # CONFIG_SYSCTL is not set
   CONFIG_NFS_FS=y
   CONFIG_NFS_V3=y
   CONFIG_NFS_V4=y
   # CONFIG_NFSD is not set
   CONFIG_SUNRPC=y
   CONFIG_SUNRPC_GSS=y

Most code in net/sunrpc only references the tk_pid field inside of calls
to `dprintk', which is a macro that does nothing unless DEBUG_RPC is
defined; however the three lines mentioned in the error messages above
use ordinary printks, and so don't compile unless DEBUG_RPC is defined.
Perhaps these three lines should also use dprintk.

-Miles
-- 
`Life is a boundless sea of bitterness'
