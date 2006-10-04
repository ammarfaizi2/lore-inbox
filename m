Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWJDOq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWJDOq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWJDOq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:46:26 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4533 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161148AbWJDOqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:46:25 -0400
Date: Wed, 4 Oct 2006 10:45:51 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 3/12] i386: Force section size to be non-zero to prevent a symbol becoming absolute
Message-ID: <20061004144551.GB16218@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003170908.GC3164@in.ibm.com> <200610041302.46672.ak@suse.de> <m1fye4cgyf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fye4cgyf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 08:07:36AM -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> >>    /* writeable */
> >> @@ -64,6 +66,7 @@ SECTIONS
> >>  	*(.data.nosave)
> >>    	. = ALIGN(4096);
> >>    	__nosave_end = .;
> >> +	LONG(0)
> >>    }
> >>  
> >>    . = ALIGN(4096);
> >
> > You're wasting one full page once for each of these LONG(0)s because
> > of the following 4096 alignment.
> >
> > Isn't there some way to do this less wastefull?
> 
> So the problem is that we have sections that don't get relocated which
> confuses things.  If the first that happened was that the size was
> check to see if it was non-zero before we did anything I think we
> wouldn't care if the linker messed up in this way.
> 

Actually in this case if section size is zero, linker does not even
output that section and simply gets rid of it. What is left behind is
just the symbols (which were supposed to be section relative) and linker
just makes those symbols as absolute symbols. Absolute symbols are not 
to be relocated so patch just filters out those symbols and they don't
get relocated. So I am not sure where can I check the section size?

One other possible solution is that kernel code is written carefully 
so that we don't run into such problems even if absolute symbols don't
get relocated. For example, if there are two symbols A and B denoting
section start and end, always check if (A<B) before doing anything. Also
make sure that one is not trying to handle multiple sections at the same
time. For example, if A and B represents start and end for section 1
and C and D represent start and end for section 2 then one wants to 
free memory between A and D , then it should be done in two steps.

if (A<B)
	free_memory(A,B)
if (C<D)
	free_memory(C,D)

So this code will become safe even if symbols for empty sections become
absolute.  

But this looks to be very awkward solution.

Thanks
Vivek
