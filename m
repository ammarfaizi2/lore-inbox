Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWJDUyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWJDUyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWJDUyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:54:35 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:49027 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751119AbWJDUye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:54:34 -0400
Message-ID: <45241F7A.5050501@us.ibm.com>
Date: Wed, 04 Oct 2006 13:54:18 -0700
From: Mike Mason <mmlnx@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: jrs@us.ibm.com
CC: Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>
Subject: Re: Fwd: Any way to find the network usage by a process?
References: <3420082f0610030114o5b44b8ak7797483e02002614@mail.gmail.com> <3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com> <452285FD.7010909@us.ibm.com>
In-Reply-To: <452285FD.7010909@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a variation of Jose's script that uses the networking tapset and 
prints top-like output for transmits and receives.  Much of the activity 
shows up under pid 0, which Jose's script filtered out.  This obviously 
doesn't reflect the actual process generating the traffic.

The networking tapset currently probes netif_receive_skb() for receives and 
dev_queue_xmit() for transmits.  Can anyone suggest better probe points to 
get transmits and receives by pid?

- Mike

Sample output:

   PID   UID DEV     XMIT_PK RECV_PK XMIT_KB RECV_KB COMMAND
     0     0 eth0        493     880      32    1238 swapper
  3078     0 eth0         26       2      28       2 Xvnc
13957     0 eth0          1       2       0       2 lspci
  3148     0 eth0          1       2       0       2 nautilus
  5058     0 eth0          1       1       0       1 firefox-bin
12277     0 eth0          1       0       0       0 sshd

nettop.stp script:

global ifxmit_p, ifrecv_p, ifxmit_b, ifrecv_b, ifdevs, ifpid, execname, user

probe netdev.transmit
{
         execname[pid()] = execname()
         user[pid()] = uid()
         ifdevs[pid(), dev_name] = dev_name
         ifxmit_p[pid(), dev_name] ++
         ifxmit_b[pid(), dev_name] += length
         ifpid[pid(), dev_name] ++
}

probe netdev.receive
{
         execname[pid()] = execname()
         user[pid()] = uid()
         ifdevs[pid(), dev_name] = dev_name
         ifrecv_p[pid(), dev_name] ++
         ifrecv_b[pid(), dev_name] += length
         ifpid[pid(), dev_name] ++
}


function print_activity()
{
         printf("%5s %5s %-7s %7s %7s %7s %7s %-15s\n",
                 "PID", "UID", "DEV", "XMIT_PK", "RECV_PK", "XMIT_KB",
		"RECV_KB", "COMMAND")

         foreach ([pid,dev] in ifpid-) {
                 printf("%5d %5d %-7s %7d %7d %7d %7d %-15s\n",
                         pid, user[pid], dev,
			ifxmit_p[pid, dev], ifrecv_p[pid, dev],                        		 
ifxmit_b[pid, dev]/1024,
  			ifrecv_b[pid, dev]/1024,
                         execname[pid])
         }

         print("\n")

         delete execname
         delete user
         delete ifdevs
         delete ifxmit_p
         delete ifrecv_p
         delete ifxmit_b
         delete ifrecv_b
         delete ifpid
}

probe timer.ms(5000)
{
         print_activity()
}


Jose R. Santos wrote:
> Irfan Habib wrote:
>> Hi,
>>
>> Is there any method either kernel or user level which tells me which
>> process is generating how much traffic from a machine. For example if
>> some process is flooding the network, then I would like to know which
>> process (PID ideally), is generating the most traffic.
>>
>>   
> 
> A while ago I did a SystemTap script to solve a problem similar to 
> this.  It's been siting in my system for a while collecting dust and you 
> currently don't need the embedded C code since the networking.stp tapset 
> has all this script needs(and more), but I should point you in the right 
> direction.
> 
> This worked a couple of months ago but it is currently untested.  Hope 
> it helps.
> 
> -JRS
> 
> 
> global ifstats, ifdevs, execname
> 
> %{
> #include<linux/skbuff.h>
> #include<linux/netdevice.h>
> %}
> 
> probe kernel.function("dev_queue_xmit")
> {
>        execname[pid()] = execname()
>        name=skb_to_name($skb)
>        ifdevs[name] = name
>        ifstats[pid(),name] <<< 1
> }
> 
> function skb_to_name:string (skbuff:long)
> %{
>        struct sk_buff *skbuff = (struct sk_buff *)((long)THIS->skbuff);
>        struct net_device *netdev = skbuff->dev;
>        sprintf (THIS->__retvalue, "%s" , netdev->name);
> %}
> 
> probe timer.ms(5000)
> {
>        exit()
> }
> 
> probe end {
>        foreach( pid in execname) {
>                if (pid == 0) continue
>                printf("%15s[%5d] ->\t", execname[pid],pid)
>                foreach( ifname in ifdevs) {
>                        printf("[%s:%7d] \t", ifname, @count(ifstats[pid, 
> ifname]))
>                }
>                print("\n")
>        }
>        print("\n")
> }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

