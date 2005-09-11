Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVIKA6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVIKA6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVIKA6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:58:40 -0400
Received: from smtp04.auna.com ([62.81.186.14]:46275 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S964786AbVIKA6j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:58:39 -0400
Date: Sun, 11 Sep 2005 00:58:08 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.13-mm2
To: Linux-Kernel Lista <linux-kernel@vger.kernel.org>
Cc: Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
	<1126396015l.6300l.1l@werewolf.able.es>
	<20050910165659.5eea90d0.akpm@osdl.org> <4323753D.9030007@trash.net>
	<1126399776l.6300l.2l@werewolf.able.es>
In-Reply-To: <1126399776l.6300l.2l@werewolf.able.es> (from
	jamagallon@able.es on Sun Sep 11 02:49:36 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1126400288l.6300l.3l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.208.222] Login:jamagallon@able.es Fecha:Sun, 11 Sep 2005 02:58:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.11, J.A. Magallon wrote:
> 
> On 09.11, Patrick McHardy wrote:
> > Andrew Morton wrote:
> > > "J.A. Magallon" <jamagallon@able.es> wrote:
> > > 
> > >>I can not ifup an interface while iptables is using it.
> > >>Is this expected behaviour ?
> > > 
> > > Maybe it's expected, but breaking existing userspace is a serious issue.
> > 
> > No, its not expected.
> > 
> > >>There is a possible bug (IMHO) in Mandrake initscripts, that start iptables
> > >>before network interfaces, but this had always worked.
> > >>
> > >>Any ideas ?
> > 
> > What's happening when you try to set the interface up? Please
> > provide output of ifup and strace of the failing command. Thanks.
> 
> werewolf:~# ifdown eth0
> werewolf:~# service iptables start
> Applying iptables firewall rules: 
>                                                                 [  OK  ]
> werewolf:~# iptables -v -t nat -L
> Chain PREROUTING (policy ACCEPT 2 packets, 156 bytes)
>  pkts bytes target     prot opt in     out     source               destination         
> 
> Chain POSTROUTING (policy ACCEPT 5 packets, 300 bytes)
>  pkts bytes target     prot opt in     out     source               destination         
>     0     0 MASQUERADE  all  --  any    eth0    anywhere             anywhere            
> 
> Chain OUTPUT (policy ACCEPT 5 packets, 300 bytes)
>  pkts bytes target     prot opt in     out     source               destination         
> werewolf:~# iptables -v -t filter -L
> Chain INPUT (policy ACCEPT 257 packets, 51631 bytes)
>  pkts bytes target     prot opt in     out     source               destination         
> 
> Chain FORWARD (policy DROP 0 packets, 0 bytes)
>  pkts bytes target     prot opt in     out     source               destination         
>     0     0 ACCEPT     all  --  eth0   eth1    anywhere             anywhere            state RELATED,ESTABLISHED 
>     0     0 ACCEPT     all  --  eth1   eth0    anywhere             anywhere            
> 
> Chain OUTPUT (policy ACCEPT 251 packets, 51163 bytes)
>  pkts bytes target     prot opt in     out     source               destination         
> 
> werewolf:~# ifup eth0
> 
> Determining IP information for eth0...Operation failed.
>  failed.
> 
> I traced the problem to pump, and I did a diff between strace of pump
> when it works and when it doesnt (witout and with iptables started):
> 
>  socket(PF_FILE, SOCK_STREAM, 0)         = 3
>  connect(3, {sa_family=AF_FILE, path="/var/run/pump.sock"}, 20) = 0
>  write(3, "\0\0\0\0eth0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\300"..., 4280) = 4280
> -read(3, "\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4280) = 4280
> -exit_group(0)                           = ?
> -Process 7931 detached
> +read(3, "\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4280) = 4280
> +socket(PF_FILE, SOCK_STREAM, 0)         = 4
> +connect(4, {sa_family=AF_FILE, path="/var/run/pump.sock"}, 20) = 0
> +write(4, "\0\0\0\0eth0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\300"..., 4280) = 4280
> +read(4, "\1\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4280) = 4280
> +write(2, "Operation failed.\n", 18Operation failed.
> +)     = 18
> +exit_group(1)                           = ?
> +Process 7822 detached
> 
> pump seems to write something in the socket, try to read it again and gets
> different results.
> 
> Note, my iptables are modular and I did not unload the modules, just stopped
> them with 'service iptables stop'. Digging further, if I just do
> iptables -t nat -F, pump works again.
> 
> Hope this helps.
> 

And I also get this on syslog:

Sep 11 02:56:58 werewolf kernel: MASQUERADE: eth0 ate my IP address
Sep 11 02:56:58 werewolf kernel: MASQUERADE: eth0 ate my IP address


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.13-jam3 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))


