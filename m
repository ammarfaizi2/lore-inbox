Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVJKKzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVJKKzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 06:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVJKKzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 06:55:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4331 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751397AbVJKKzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 06:55:22 -0400
Message-ID: <434B9A02.8010005@RedHat.com>
Date: Tue, 11 Oct 2005 06:54:58 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kNFSD - Allowing rpc.nfsd to setting of the port, transport
 and version the server will use
References: <43469FA7.7020908@RedHat.com> <17227.5288.236699.46660@cse.unsw.edu.au>
In-Reply-To: <17227.5288.236699.46660@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Neil,

Thanks for taking a look at this...

Neil Brown wrote:
> I've taken the 'version' bit, modified is so:
>  2/ You can only change the setting when there are no active threads. 
Good point...
> 
> New version this part patch follows.  It should be completely
> compatible with your patch. from a user-space perspective.
cool... thanks for thinking about this...

> 
> The 'port' bit I had trouble liking.
> You write:
> 
>    family proto proto addr port
> 
> to the 'ports' file.
> 'family' and 'addr' are completely ignored.
Well at this point they are not needed since we
only support ipv4... and I can only assume when we do
support other families, changing this interface will be
the least of our problems... ;-)

> 'port' is effectively ignored (value is stored in a variable which
> isn't used).
I'm not sure I understand this... nfsd_port is set and used in
nfsd_svc()
@@ -104,11 +152,14 @@ nfsd_svc(unsigned short port, int nrserv
  		nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE);
  		if (nfsd_serv == NULL)
  			goto out;
+		if (NFSCTL_UDPISSET(nfsd_portbits))
+			port = nfsd_port;
  		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
  		if (error < 0)
  			goto failure;
  #ifdef CONFIG_NFSD_TCP
+		if (NFSCTL_TCPISSET(nfsd_portbits))
+			port = nfsd_port;
  		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
  		if (error < 0)
  			goto failure;

iff the nfsd_portbits are set... which is exactly the same concept
used with the version bits... so I am a bit confused on what you want...
> 
> That leaves 'proto' and 'proto'.  One should be 'tcp' or 'notcp', the
> other should be 'udp' or 'noudp'.  Which is which?  Udp comes first,
> but it isn't at all obvious from the interface..
Maybe being the author of these interfaces you have a better perspective
than I, but I could say the same thing about all the interfaces under
/proc/fs/nfsd... :-) So I do agree... its not that obvious, but I guess
I didn't think it needed to be.. Who else do you see, other than
rpc.nfsd, using this interface?

> I think you should write:
>  [+-]family proto addr port
> 
> and every field must be checked and used.
> So while we only support ipv4, the 'family' must by 'ipv4' or an error
> is returned.
> '+' adds an endpoint.  '-' removes it.
Understood... And I'll assume the default of both TCP and UDP
listening on port 2048 will stay the same when nothing
is specified...

> 
> The old nfssvc syscall should add 'ipv4 udp * %port' and 'ipv4 tcp *
> %port' if they don't already exist.
Won't this break backwards compatibility with all the 2.4 kernels?
The beauty of seq files is that you can change the interface
and have no effect on kABI at all... which is really a good thing
in my world... So why do we even care about the old syscall interface?

> 
> An alternate interface, which would be quite appealing, would be to
> require the user-space program to create and bind a socket and then
> communicate it to the kernel, possibly by writing a file-descriptor
> number to a file in the nfsd filesystem.
> 'nfsd' would check it is an appropriate type of socket, take
> an extra reference, and use it.
> This would probably be best done *after* the nfsd threads were
> started, so there would need to be a way to start threads without
> them automatically opening sockets.  I'm not sure what the best
> interface for that would be... Maybe establishing sockets before the
> thread would be ok.
Maybe I'm missing something here.... but I'm not quite sure how passing
a fd to the kernel would help, other than (possibly) with error 
processing... The kernel will still need to know the port and proto so
it can register them with the  portmapper... plus permissions could
become an problem especially with things like selinux running around..


steved.

