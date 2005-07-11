Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVGKPyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVGKPyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVGKPwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:52:17 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:11909 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262051AbVGKPuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:50:21 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Mon, 11 Jul 2005 16:50:33 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507111538.22551.s0348365@sms.ed.ac.uk> <20050711144328.GA18244@elte.hu>
In-Reply-To: <20050711144328.GA18244@elte.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JVp0CiADg6tqW2K"
Message-Id: <200507111650.33187.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_JVp0CiADg6tqW2K
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 11 Jul 2005 15:43, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > It's annoying that this is so readily reproducible here, yet almost
> > impossible to debug, and clearly a sideaffect of 4KSTACKS.. without it
> > actually being a stack overflow.
> >
> > I realise 4KSTACKS is a considerable rework of the IRQ handler, etc.
> > and probably even more heavily modified by rt-preempt, but is there
> > nothing else that can be tested before a serial console run?
>
> 4K stacks never really caused any trouble under PREEMPT_RT (or any other
> kernel i tried). It's not that complex either.
>
> one useful thing could be to give me exact instructions on how to set up
> an openvpn network similar to yours, and what kind of workload to
> generate. Maybe i can reproduce it here.

OpenVPN isn't terribly difficult to set up, but it's more than a 5 minute job. 
You'll need universal tun/tap in your kernel before you start, and openvpn 
itself installed (I've compiled from source and used Debian's 2.0.0 package, 
I'm sure Red Hat has an equivalent), then it's just a case of setting up a 
client and a server.

If you like, I can generate the "keys" used for server/client and I've 
attached the configs for the server and the client they we use here. 
Obviously for security reasons I can't attach OUR keys verbatim, but I'll 
instruct you on how to generate them.

So, on the server:

a) Install OpenVPN
b) mkdir -p /etc/openvpn/keys
c) Copy attached server.conf to /etc/openvpn
d) Modify server.conf if necessary (shouldn't be required)
e) Generate your server and client keys (see below)

This mostly repeats the moderately good documentation on 
http://openvpn.net/howto.html, but I can't expect you to read it all so I'll 
give you a bite-sized version. It saves you figuring out the same rubbish I 
had to about 6 months ago. OpenVPN will create (with my configs) a verbose 
log in /etc/openvpn/log on both machines.

1) cd /usr/share/doc/openvpn/easy-rsa

2) Edit "vars". Change line export KEY_DIR=... to:

	export KEY_DIR=/etc/openvpn/keys

3) Save and exit

4) On Bash (at least) type

	. ./vars

	Which imports "vars" into your environment.

5) ./clean-all

6) ./build-ca (enter any old crap)

7) ./build-key-server server

	Enter the common-name as "server" again. No password.

8) Finally, generate the client key (used by the client for crypto)

	./build-key client1

	Where "client1" is an arbitrary name. When prompted for "common-name", enter
	the same string; this is important and I was head-scratching for some time
	as to why it wouldn't work without this... Again no password.

8) ./build-dh (this takes a while)

With that done, /etc/openvpn/keys should contain at least..

01.pem
ca.{crt,key}
dh1024.pem
server.{crt,csr,key}
client1.{crt,csr,key}

Plus some other cruft that's probably not required. Now you should be able to 
start the openvpn server with something like..

openvpn --cd /etc/openvpn --config server.conf

Add some other flags like verbose if you want to see what's happening. 
Remember it's logging everything to /etc/openvpn/log which you can supress by 
commenting out the logfile line in the config.

It'll bring up a tun device on the server side, and wait patiently for VPN 
connections.

The client side is a piece of cake.

1) mkdir /etc/openvpn

2) Copy client1.crt, client1.key, and ca.crt from the server's /etc/openvpn 
directory to the client's /etc/openvpn directory.

3) Copy the attached client.conf to the same directory.

4) Edit the config as necessary and save (should work with only the server IP 
changes).

Again, the client machine will need to have the universal tun/tap driver 
loaded. Bring up the openvpn with:

openvpn --cd /etc/openvpn --config client.conf

A connection should be established and, hopefully, you'll get a pingable route 
to 10.0.0.1. I then made this my default gateway with:

route del default wlan
route add default tun0

Then I was able to ping machines on the server side without having a local 
gateway to them. One working VPN.

I suggest you try all this on a "stable" kernel, and once you've established 
it works, just transfer a file at a reasonable data rate through the tunnel.

Ours links to a company server with a consumer grade 1Mbit ADSL connection, 
and transferring just about anything at 110K/s causes the kernel to crash 
within about 10 seconds.

I wish you the best of luck with getting this going, and I apologise in 
advance for the poor instructions.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.

--Boundary-00=_JVp0CiADg6tqW2K
Content-Type: text/plain;
  charset="iso-8859-1";
  name="client.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="client.conf"

client
remote 192.168.99.1 443

ca ca.crt
cert client1.crt
key client1.key
ns-cert-type server

dev tun
proto udp
nobind
user nobody
group nobody

persist-key
persist-tun

log /etc/openvpn/log
verb 3

--Boundary-00=_JVp0CiADg6tqW2K
Content-Type: text/plain;
  charset="iso-8859-1";
  name="server.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="server.conf"

server 10.0.0.0 255.255.255.0
port 443

ca keys/ca.crt
cert keys/server.crt
key keys/server.key
dh keys/dh1024.pem

dev tun
proto udp
user nobody
group nogroup

persist-key
persist-tun
ifconfig-pool-persist ipp

log /etc/openvpn/log
verb 3

client-to-client
push "redirect-gateway def1"
push "dhcp-option DNS 192.168.1.1"
push "dhcp-option WINS 192.168.1.2"

--Boundary-00=_JVp0CiADg6tqW2K--
