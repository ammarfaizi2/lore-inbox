Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTF3CVN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 22:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTF3CVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 22:21:13 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:38334 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265073AbTF3CVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 22:21:06 -0400
Message-ID: <3EFFA1EA.7090502@nortelnetworks.com>
Date: Sun, 29 Jun 2003 22:35:22 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: [BUG]:   problem when shutting down ppp connection since 2.5.70
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
On 2.5.70 and later kernels, shutting down a pppoe connection causes 
pppd to hang and results in a usage count stuck at 1.

Details:

I have a pppoe dsl connection and I use the roaring penguin stuff that 
comes default with Mandrake 9.  My connection is brought up at init 
time.  With kernels past 2.5.69, if I try and shut down the connection I 
get logs as follows:


Jun 29 17:18:29 doug adsl-stop: Killing pppd
Jun 29 17:18:29 doug pppd[779]: Terminating on signal 15.
Jun 29 17:18:29 doug adsl-stop: Killing adsl-connect
Jun 29 17:18:29 doug pppd[779]: Connection terminated.
Jun 29 17:18:29 doug pppd[779]: Connect time 1.3 minutes.
Jun 29 17:18:29 doug pppd[779]: Sent 902 bytes, received 588 bytes.
Jun 29 17:18:32 doug pppoe[781]: Session 2991 terminated -- received 
PADT from peer
Jun 29 17:18:32 doug pppoe[781]: Sent PADT
Jun 29 17:18:39 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 29 17:18:45 doug ntpd[1094]: sendto(132.246.168.148): Invalid argument
Jun 29 17:18:46 doug smbd[1510]: [2003/06/29 17:18:46, 0] 
smbd/server.c:open_sockets(238)
Jun 29 17:18:46 doug smbd[1510]:   Got SIGHUP
Jun 29 17:18:46 doug smb: smbd -HUP succeeded
Jun 29 17:18:49 doug kernel: unregister_netdevice: waiting for ppp0 to 
become free. Usage count = 1
Jun 29 17:19:29 doug last message repeated 4 times
Jun 29 17:20:39 doug last message repeated 7 times


Also, pppd is stuck in a busy-loop, and isn't killable even with -9. 
Interestingly, top shows it in the R state.  I thought that wasn't 
supposed to happen?

With 2.5.69, the shutdown messages look like:

Jun 29 21:56:17 doug adsl-stop: Killing pppd
Jun 29 21:56:17 doug pppd[778]: Terminating on signal 15.
Jun 29 21:56:17 doug adsl-stop: Killing adsl-connect
Jun 29 21:56:17 doug pppd[778]: Connection terminated.
Jun 29 21:56:17 doug pppd[778]: Connect time 9.7 minutes.
Jun 29 21:56:17 doug pppd[778]: Sent 1510 bytes, received 588 bytes.
Jun 29 21:56:17 doug pppoe[781]: read (asyncReadFromPPP): Session 14: 
Input/output error
Jun 29 21:56:17 doug pppoe[781]: Sent PADT
Jun 29 21:56:17 doug pppd[778]: Exit.

The cpu is an athlon xp, no modules loaded.

One interesting tidbit is that this doesn't seem to happen if I remove 
the dsl connection from init and do it manually later.

I did a quick scan of the ppp*.c files in drivers/net and these are the 
ones with updates that went into 2.5.70.

Affected files are:
ppp_deflate.c 1.10
ppp_generic.c 1.25-1.30
ppp_synctty.c 1.9

Affected userids:
akpm
davem
paulus
torvalds


If anyone wants to propose a patch, I'm willing to try it out.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

