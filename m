Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWDHUeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWDHUeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWDHUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:34:09 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27087 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751408AbWDHUeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:34:07 -0400
Date: Sat, 8 Apr 2006 15:27:01 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] uts namespaces: use init_utsname when appropriate
Message-ID: <20060408202701.GA26403@sergelap.austin.ibm.com>
References: <20060407234815.849357768@sergelap> <20060408045206.EAA8E19B8FF@sergelap.hallyn.com> <m1psjslf1s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psjslf1s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > diff --git a/include/asm-i386/elf.h b/include/asm-i386/elf.h
> > index 4153d80..8d455e2 100644
> > --- a/include/asm-i386/elf.h
> > +++ b/include/asm-i386/elf.h
> > @@ -108,7 +108,7 @@ typedef struct user_fxsr_struct elf_fpxr
> >     For the moment, we have only optimizations for the Intel generations,
> >     but that could change... */
> >  
> > -#define ELF_PLATFORM  (system_utsname.machine)
> > +#define ELF_PLATFORM  (init_utsname()->machine)
> >  
> >  #ifdef __KERNEL__
> >  #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
> 
> I think this one needs to be utsname()->machine.
> 
> Currently it doesn't matter.  But Herbert has expressed
> the desire to make a machine appear like an older one.

Ok.

> > diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> > index cb8a92f..81db372 100644
...
> > @@ -1479,11 +1479,11 @@ static int __init ip_auto_config_setup(c
> >  			case 4:
> >  				if ((dp = strchr(ip, '.'))) {
> >  					*dp++ = '\0';
> > -					strlcpy(system_utsname.domainname, dp,
> > - sizeof(system_utsname.domainname));
> > +					strlcpy(init_utsname()->domainname, dp,
> > + sizeof(init_utsname()->domainname));
> >  				}
> > -				strlcpy(system_utsname.nodename, ip,
> > -					sizeof(system_utsname.nodename));
> > +				strlcpy(init_utsname()->nodename, ip,
> > +					sizeof(init_utsname()->nodename));
> >  				ic_host_name_set = 1;
> >  				break;
> >  			case 5:
> 
> This also probably makes sense as utsname().  It doesn't
> really matter as this is before init is executed. But logically
> this is a user space or per namespace action.

Right, I was kind of favoring using init_utsname() for anything
__init.  But utsname() will of course work just as well there.

> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index aa8965e..97c8439 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -176,10 +176,10 @@ rpc_new_client(struct rpc_xprt *xprt, ch
> >  	}
> >  
> >  	/* save the nodename */
> > -	clnt->cl_nodelen = strlen(system_utsname.nodename);
> > +	clnt->cl_nodelen = strlen(init_utsname()->nodename);
> >  	if (clnt->cl_nodelen > UNX_MAXNODENAME)
> >  		clnt->cl_nodelen = UNX_MAXNODENAME;
> > -	memcpy(clnt->cl_nodename, system_utsname.nodename, clnt->cl_nodelen);
> > +	memcpy(clnt->cl_nodename, init_utsname()->nodename, clnt->cl_nodelen);
> >  	return clnt;
> >  
> >  out_no_auth:
> 
> Using nodename is practically the definition of something
> that should per namespace I think.  Plus it would be really inconsistent
> to use utsname() and the init_utsname for the nfs rpc calls.
> 
> Unless I am missing something.

It seemed like this would be happening in any old context, so that
current->uts_ns could be any process'.  Tracing it back further,
it seems like nfs+lockd should have the context available.  So I'll
switch this as well.

thanks,
-serge
