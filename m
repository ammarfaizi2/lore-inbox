Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWDHHLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWDHHLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 03:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWDHHLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 03:11:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52935 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751356AbWDHHLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 03:11:16 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] uts namespaces: use init_utsname when appropriate
References: <20060407234815.849357768@sergelap>
	<20060408045206.EAA8E19B8FF@sergelap.hallyn.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 08 Apr 2006 01:09:03 -0600
In-Reply-To: <20060408045206.EAA8E19B8FF@sergelap.hallyn.com> (Serge E.
 Hallyn's message of "Fri,  7 Apr 2006 23:52:06 -0500 (CDT)")
Message-ID: <m1psjslf1s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> diff --git a/include/asm-i386/elf.h b/include/asm-i386/elf.h
> index 4153d80..8d455e2 100644
> --- a/include/asm-i386/elf.h
> +++ b/include/asm-i386/elf.h
> @@ -108,7 +108,7 @@ typedef struct user_fxsr_struct elf_fpxr
>     For the moment, we have only optimizations for the Intel generations,
>     but that could change... */
>  
> -#define ELF_PLATFORM  (system_utsname.machine)
> +#define ELF_PLATFORM  (init_utsname()->machine)
>  
>  #ifdef __KERNEL__
>  #define SET_PERSONALITY(ex, ibcs2) do { } while (0)

I think this one needs to be utsname()->machine.

Currently it doesn't matter.  But Herbert has expressed
the desire to make a machine appear like an older one.



> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index cb8a92f..81db372 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -367,7 +367,7 @@ static int __init ic_defaults(void)
>  	 */
>  	 
>  	if (!ic_host_name_set)
> - sprintf(system_utsname.nodename, "%u.%u.%u.%u", NIPQUAD(ic_myaddr));
> + sprintf(init_utsname()->nodename, "%u.%u.%u.%u", NIPQUAD(ic_myaddr));
>  
>  	if (root_server_addr == INADDR_NONE)
>  		root_server_addr = ic_servaddr;
> @@ -806,7 +806,7 @@ static void __init ic_do_bootp_ext(u8 *e
>  			}
>  			break;
>  		case 12:	/* Host name */
> - ic_bootp_string(system_utsname.nodename, ext+1, *ext, __NEW_UTS_LEN);
> + ic_bootp_string(init_utsname()->nodename, ext+1, *ext, __NEW_UTS_LEN);
>  			ic_host_name_set = 1;
>  			break;
>  		case 15:	/* Domain name (DNS) */
> @@ -817,7 +817,7 @@ static void __init ic_do_bootp_ext(u8 *e
>  				ic_bootp_string(root_server_path, ext+1, *ext,
> sizeof(root_server_path));
>  			break;
>  		case 40:	/* NIS Domain name (_not_ DNS) */
> - ic_bootp_string(system_utsname.domainname, ext+1, *ext, __NEW_UTS_LEN);
> + ic_bootp_string(init_utsname()->domainname, ext+1, *ext, __NEW_UTS_LEN);
>  			break;
>  	}
>  }
> @@ -1369,7 +1369,7 @@ static int __init ip_auto_config(void)
>  	printk(", mask=%u.%u.%u.%u", NIPQUAD(ic_netmask));
>  	printk(", gw=%u.%u.%u.%u", NIPQUAD(ic_gateway));
>  	printk(",\n     host=%s, domain=%s, nis-domain=%s",
> -	       system_utsname.nodename, ic_domain, system_utsname.domainname);
> + init_utsname()->nodename, ic_domain, init_utsname()->domainname);
>  	printk(",\n     bootserver=%u.%u.%u.%u", NIPQUAD(ic_servaddr));
>  	printk(", rootserver=%u.%u.%u.%u", NIPQUAD(root_server_addr));
>  	printk(", rootpath=%s", root_server_path);
> @@ -1479,11 +1479,11 @@ static int __init ip_auto_config_setup(c
>  			case 4:
>  				if ((dp = strchr(ip, '.'))) {
>  					*dp++ = '\0';
> -					strlcpy(system_utsname.domainname, dp,
> - sizeof(system_utsname.domainname));
> +					strlcpy(init_utsname()->domainname, dp,
> + sizeof(init_utsname()->domainname));
>  				}
> -				strlcpy(system_utsname.nodename, ip,
> -					sizeof(system_utsname.nodename));
> +				strlcpy(init_utsname()->nodename, ip,
> +					sizeof(init_utsname()->nodename));
>  				ic_host_name_set = 1;
>  				break;
>  			case 5:

This also probably makes sense as utsname().  It doesn't
really matter as this is before init is executed. But logically
this is a user space or per namespace action.

> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index aa8965e..97c8439 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -176,10 +176,10 @@ rpc_new_client(struct rpc_xprt *xprt, ch
>  	}
>  
>  	/* save the nodename */
> -	clnt->cl_nodelen = strlen(system_utsname.nodename);
> +	clnt->cl_nodelen = strlen(init_utsname()->nodename);
>  	if (clnt->cl_nodelen > UNX_MAXNODENAME)
>  		clnt->cl_nodelen = UNX_MAXNODENAME;
> -	memcpy(clnt->cl_nodename, system_utsname.nodename, clnt->cl_nodelen);
> +	memcpy(clnt->cl_nodename, init_utsname()->nodename, clnt->cl_nodelen);
>  	return clnt;
>  
>  out_no_auth:

Using nodename is practically the definition of something
that should per namespace I think.  Plus it would be really inconsistent
to use utsname() and the init_utsname for the nfs rpc calls.

Unless I am missing something.

Eric

