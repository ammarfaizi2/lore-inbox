Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266135AbUBCVFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUBCVFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:05:10 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:17521 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S266135AbUBCVFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:05:00 -0500
Date: Tue, 3 Feb 2004 22:04:58 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 11/42]
Message-ID: <20040203210458.GA1337@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan> <20040202194452.GK6785@dreamland.darkstar.lan> <Pine.LNX.4.53.0402021622390.28946@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402021622390.28946@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, Feb 02, 2004 at 04:25:55PM -0500, Richard B. Johnson ha scritto: 
> On Mon, 2 Feb 2004, Kronos wrote:
> 
> >
> > include/asm/smpboot.h:126: warning: deprecated use of label at end of compound statement
> >
> > Move the return statement under 'default' label to suppress the warning.
> >
> > diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/smpboot.h linux-2.4/include/asm-i386/smpboot.h
> > --- linux-2.4-vanilla/include/asm-i386/smpboot.h	Tue Nov 11 17:51:14 2003
> > +++ linux-2.4/include/asm-i386/smpboot.h	Sat Jan 31 17:10:50 2004
> > @@ -123,8 +123,8 @@
> >  			cpu = (cpu+1)%smp_num_cpus;
> >  			return cpu_to_physical_apicid(cpu);
> >  		default:
> > +			return cpu_online_map;
> >  	}
> > -	return cpu_online_map;
> >  }
> >  #else
> >  #define target_cpus() (cpu_online_map)
> >
> 
> Not correct. This removes the main-line return of a value.

Since the original code is this:

        switch(clustered_apic_mode){
                case CLUSTERED_APIC_NUMAQ:
                        /* Broadcast intrs to local quad only. */
                        return APIC_BROADCAST_ID_APIC;
                case CLUSTERED_APIC_XAPIC:
                        /*round robin the interrupts*/
                        cpu = (cpu+1)%smp_num_cpus;
                        return cpu_to_physical_apicid(cpu);
                default:
        }
        return cpu_online_map;

my patch doesn't change anything. It may be a bit unclean though. What
about this one:

diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/smpboot.h linux-2.4/include/asm-i386/smpboot.h
--- linux-2.4-vanilla/include/asm-i386/smpboot.h	Sun Aug 31 23:04:50 2003
+++ linux-2.4/include/asm-i386/smpboot.h	Tue Feb  3 22:03:06 2004
@@ -123,6 +123,7 @@
 			cpu = (cpu+1)%smp_num_cpus;
 			return cpu_to_physical_apicid(cpu);
 		default:
+			break;
 	}
 	return cpu_online_map;
 }



Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
I went to God just to see
And I was looking at me
Saw heaven and hell were lies
When I'm God everyone dies
