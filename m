Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVJLEXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVJLEXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 00:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVJLEXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 00:23:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:2280 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932418AbVJLEX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 00:23:29 -0400
From: Neil Brown <neilb@suse.de>
To: Steve Dickson <SteveD@redhat.com>
Date: Wed, 12 Oct 2005 14:23:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17228.36788.911900.280394@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kNFSD - Allowing rpc.nfsd to setting of the port, transport
 and version the server will use
In-Reply-To: message from Steve Dickson on Tuesday October 11
References: <43469FA7.7020908@RedHat.com>
	<17227.5288.236699.46660@cse.unsw.edu.au>
	<434B9A02.8010005@RedHat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 11, SteveD@redhat.com wrote:
> > 
> > The 'port' bit I had trouble liking.
> > You write:
> > 
> >    family proto proto addr port
> > 
> > to the 'ports' file.
> > 'family' and 'addr' are completely ignored.
> Well at this point they are not needed since we
> only support ipv4... and I can only assume when we do
> support other families, changing this interface will be
> the least of our problems... ;-)

Maybe, but either we make it ready for future needs now, or we only
support current needs and allow a clear upgrade path.
Ignoring fields which might later have a meaning is bad because it
means that user-space code which works now much break later for no
good reason.  
My basic position wrt this is that if the fields are there, they
should be checked.

> 
> > 'port' is effectively ignored (value is stored in a variable which
> > isn't used).
> I'm not sure I understand this... nfsd_port is set and used in
> nfsd_svc()
> @@ -104,11 +152,14 @@ nfsd_svc(unsigned short port, int nrserv
>   		nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE);
>   		if (nfsd_serv == NULL)
>   			goto out;
> +		if (NFSCTL_UDPISSET(nfsd_portbits))
> +			port = nfsd_port;
>   		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
>   		if (error < 0)
>   			goto failure;
>   #ifdef CONFIG_NFSD_TCP
> +		if (NFSCTL_TCPISSET(nfsd_portbits))
> +			port = nfsd_port;
>   		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
>   		if (error < 0)
>   			goto failure;
> 
> iff the nfsd_portbits are set... which is exactly the same concept
> used with the version bits... so I am a bit confused on what you
> want...

Uhmmmm.... that code fragment isn't in the patch you sent.  I got:

> @@ -104,14 +152,17 @@ nfsd_svc(unsigned short port, int nrserv
>  		nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE);
>  		if (nfsd_serv == NULL)
>  			goto out;
> -		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
> -		if (error < 0)
> -			goto failure;
> -
> +		if (!nfsd_portbits || NFSCTL_UDPISSET(nfsd_portbits)) {
> +			error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
> +			if (error < 0)
> +				goto failure;
> +		}
>  #ifdef CONFIG_NFSD_TCP
> -		error = svc_makesock(nfsd_serv, IPPROTO_TCP, port);
> -		if (error < 0)
> -			goto failure;
> +		if (!nfsd_portbits || NFSCTL_TCPISSET(nfsd_portbits)) {
> +			error = svc_makesock(nfsd_serv, IPPROTO_TCP, port);
> +			if (error < 0)
> +				goto failure;
> +		}
>  #endif
>  		do_gettimeofday(&nfssvc_boot);		/* record boot time */
>  	} else

I guess if you merged these two, you might get something usable..

> > 
> > That leaves 'proto' and 'proto'.  One should be 'tcp' or 'notcp', the
> > other should be 'udp' or 'noudp'.  Which is which?  Udp comes first,
> > but it isn't at all obvious from the interface..
> Maybe being the author of these interfaces you have a better perspective
> than I, but I could say the same thing about all the interfaces under
> /proc/fs/nfsd... :-) So I do agree... its not that obvious, but I guess
> I didn't think it needed to be.. Who else do you see, other than
> rpc.nfsd, using this interface?

Ok, I guess I presented by difficulty with this rather badly.  The
order does seem arbitrary and non-obvious, but you are right that
other things are no-obvious too...
The point I should have made was that it is non-extensible. 
Suppose NFSv4.4 is defined to work over SCTP to even DCCP (which might
be ideal for NFS), how would we specify those?

> 
> > I think you should write:
> >  [+-]family proto addr port
> > 
> > and every field must be checked and used.
> > So while we only support ipv4, the 'family' must by 'ipv4' or an error
> > is returned.
> > '+' adds an endpoint.  '-' removes it.
> Understood... And I'll assume the default of both TCP and UDP
> listening on port 2048 will stay the same when nothing
> is specified...

Yes... but I'm not sure of the rest of the rules about defaults...
- should you need to explicitly remove the defaults if you don't want
  them?
- should there be an easy way to revert-to-defaults?  Maybe when the
  last nfsd dies, all setting are forgotten (just like currently all
  exports are removed).

  
> 
> > 
> > The old nfssvc syscall should add 'ipv4 udp * %port' and 'ipv4 tcp *
> > %port' if they don't already exist.
> Won't this break backwards compatibility with all the 2.4 kernels?
> The beauty of seq files is that you can change the interface
> and have no effect on kABI at all... which is really a good thing
> in my world... So why do we even care about the old syscall
> interface?

I don't see why it would break backwards compat.  Isn't that exactly
what the nfssvc syscall does?  You give it a port number, and it
starts the number of threads with two sockets, a udp bound to ADDR_ANY
and the given port, and a TCP bound the same way?  What is what I
meant to say above.


> 
> > 
> > An alternate interface, which would be quite appealing, would be to
> > require the user-space program to create and bind a socket and then
> > communicate it to the kernel, possibly by writing a file-descriptor
> > number to a file in the nfsd filesystem.
> > 'nfsd' would check it is an appropriate type of socket, take
> > an extra reference, and use it.
> > This would probably be best done *after* the nfsd threads were
> > started, so there would need to be a way to start threads without
> > them automatically opening sockets.  I'm not sure what the best
> > interface for that would be... Maybe establishing sockets before the
> > thread would be ok.
> Maybe I'm missing something here.... but I'm not quite sure how passing
> a fd to the kernel would help, other than (possibly) with error 
> processing... The kernel will still need to know the port and proto so
> it can register them with the  portmapper... plus permissions could
> become an problem especially with things like selinux running around..
> 

I think the principle of "do as much as possible in user-space" is a
good one. 
   socket / bind / pmap_register 
can all be done in user-space, so maybe they should be.
You could possible even argue that 
   listen / accept
the be done in user-space, and so should be, but I'm not sure I want
to push it that far.

The nice thing about just passing down a filedescriptor for a socket
is that it allows for any future additions of protocols.

I don't see how permissions could be a problem, but then I know very
little about selinux, so maybe there is something.  Is there something
specific you foresee, or is it just general concern?

NeilBrown
