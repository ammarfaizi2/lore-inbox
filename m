Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbVITOZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbVITOZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbVITOZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:25:53 -0400
Received: from trixi.wincor-nixdorf.com ([217.115.67.77]:3752 "EHLO
	trixi.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S932762AbVITOZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:25:51 -0400
Message-ID: <43301BC4.9080305@wincor-nixdorf.com>
Date: Tue, 20 Sep 2005 16:25:08 +0200
From: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Organization: Wincor Nixdorf
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel error in system call accept() under kernel 2.6.8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----------------------------------------------------------------------
One line summary of the problem:
linux accept() system call does not set always errno if the
returnvalue is negative.

----------------------------------------------------------------------
Full description of the problem/report:
Obviously there are some cases where the accept() system call does
not set the errno variable if the accept() system call returns
with a value less than zero:

Distribution : Linux Fedora Core 2 - but with kernel 2.6.8
Sample code:
--snip----------
....
//accept may return with a protocol error, simply try again
while( (n = accept(m_ListenFd, (struct sockaddr *) cliaddr, &len)) < 0)
{
   Log.Log("Error accept, fd=%d, addrlen=%d, len=%d, errno=%d, %s",
m_ListenFd,
m_AddrLen, len, errno, strerror_r(errno, l_strebuf, sizeof(l_strebuf)));
   if (errno == EPROTO || errno == ECONNABORTED)   //connection already
aborted
   {
     Log.Log("connection aborted, wait for next");
     continue;   //next try
   } else if (errno == EINTR) {    //signal
     if (CnThread::TestCancel(m_Log)) {
       Log.Log("thread is cancelled");
       delete[] cliaddr;
       return -1;
     } else {
       Log.Log("EINTR, try again");
       continue;   //next try
     }
   }
   else
   {
     throw CnException(__FILE__, __LINE__, "accept error errno=%d, %s",
errno,
strerror_r(errno, l_strebuf, sizeof(l_strebuf)));
   }
}
...
--snip-----
output:
CnTcpServer::WaitClient   Error accept, fd=19, addrlen=16, len=16,
errno=0, Success


----------------------------------------------------------------------
Keywords (i.e., modules, networking, kernel):
network accept errno error return value
----------------------------------------------------------------------
Kernel version (from /proc/version):
cat /proc/version
Linux version 2.6.8-1.521 (root@wsa92_D2_FEDTest) (gcc version 3.3.3
20040412 (Red Hat Linux 3.3.3-7)) #3 Fri Jul 8 11:08:56 CEST
2005
----------------------------------------------------------------------
----------------------------------------------------------------------
Question:
Is there any update/information/explanation about this behaviour available??


