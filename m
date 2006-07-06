Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWGFQcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWGFQcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWGFQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:32:10 -0400
Received: from k2smtpout02-02.prod.mesa1.secureserver.net ([64.202.189.91]:15786
	"HELO k2smtpout02-02.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S964984AbWGFQcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:32:08 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.4/5.0):. Processed in 0.811099 secs Process 7714)
Message-ID: <44AD3B00.6090607@plutohome.com>
Date: Thu, 06 Jul 2006 19:32:00 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] NFS with multiple clients connected
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> On Thu, 2006-07-06 at 18:15 +0300, Razvan Gavril wrote:
>> I have a nfs server(kernel-server) which i use as a boot server for 
>> several other machines on the network. Starting with 2.6.16 i started 
>> noticing that when having more than one of the clients doing a lot of 
>> in/out on their mounted nfs shares at list one of then starts to to have 
>> problems when writing (don't know about reading) files. For example dpkg 
>> writes strange things it the /var/lib/dpkg/status file even if it worked 
>> perfectly before the kernel upgrade.
>>
>> Every time an diskless computer fails to write corectly to the nfs 
>> filesystem i got this messages on the nfs server (dmesg):
>>
>> RPC: bad TCP reclen 0x3c390000 (large)
>> RPC: bad TCP reclen 0x31006261 (non-terminal)
>> RPC: bad TCP reclen 0x73752070 (non-terminal)
>> RPC: bad TCP reclen 0x52610100 (non-terminal)
>>
>> Is very simple to spot this behaver (1 write-error for client / 1 rpc 
>> message in server's dmesg) because apt-get is always giving an error 
>> message when the /var/lib/dpkg/status file contains something that it 
>> shouldn't. An it also can be very ease to reproduce.
>>
>> I tested with 2.6.17 and got the same error, although when using 2.6.15 
>> didn't got any errors and the clients worked perfect. Since i'm kind of 
>> forced to use a kernel version > 2.6.15 i really, really need to solve 
>> this bug. I would be glad to do it myself but i don't have the knowledge 
>> to do it so if is anybody that can help i can offer all the information 
>> that i could and also access to a system so he can track the problem.
>>
>>
>> --
>> Razvan Gavril
>
> Did the problem start when you upgraded the clients or the server?
>
> Cheers,
>   Trond
>
>
For now i only tested like this :

Server        Clients      State
-----------------------------------
2.6.15        2.6.15       Works
2.6.16        2.6.16       Fails
2.6.17        2.6.16       Fails
2.6.17        2.6.17       Fails


I did some more testing, i created a script that copies the files from a 
nfs share to another/same nfs share then checks the md5sums of the 
source and destination file, to my big surprise it worked ok. I did the 
test with relative small files (/lib) then with big files (dvds, avi) also.

The problem appears only when 2 diskless computers run apt-get in 
parallel so i suspect something related to bad file descriptors(?) 
,maybe apt is reading / writing / moving it's status files too quick. I 
can reproduce the problem in 20-30 seconds if i let more that 2 diskless 
computers run apt-get in parallel. I need to mention that the two 
diskless computers use completely different shares so there is no race 
condition in apt involved.

--
Razvan Gavril



