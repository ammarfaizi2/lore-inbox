Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVCIESH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVCIESH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 23:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCIESH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 23:18:07 -0500
Received: from rgminet04.oracle.com ([148.87.122.33]:49810 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261491AbVCIESB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 23:18:01 -0500
Date: Tue, 8 Mar 2005 20:07:57 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Daniel McNeil <daniel@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       S?bastien Dugu? <sebastien.dugue@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-ID: <20050309040757.GY27331@ca-server1.us.oracle.com>
Mail-Followup-To: Badari Pulavarty <pbadari@us.ibm.com>,
	Daniel McNeil <daniel@osdl.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	S?bastien Dugu? <sebastien.dugue@bull.net>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1110189607.11938.14.camel@frecb000686> <20050307223917.1e800784.akpm@osdl.org> <20050308090946.GA4100@in.ibm.com> <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com> <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com> <1110324434.6521.23.camel@ibm-c.pdx.osdl.net> <1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040907i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 03:54:04PM -0800, Badari Pulavarty wrote:
> > 1. return EINVAL if the DIO goes past EOF.
> > 
> > 2. truncate the request to file size (which is what your patch does)
> >     and if it works, it works.
> > 
> > 3. truncate the request to a size that actually works - like a multiple
> >     of 512.
> > 
> > 4. Do the full i/o since the user buffer is big enough, truncate the
> >     result returned to file size (and clear out the user buffer where it
> >     read past EOF).
> > 
> > Number 4 would make it easy on the user-level code, but AIO DIO might be
> > a bit tricky and might be a security hole since the data would be dma'ed
> > there and then cleared.  I need to look at the code some more.

	Solaris, which does forcedirectio as a mount option, actually
will do buffered I/O on the trailing part.  Consider it like a bounce
buffer.  That way they don't DMA the trailing data and succeed the I/O.
The I/O returns actual bytes till EOF, just like read(2) is supposed to.
	Either this or a fully DMA'd number 4 is really what we should
do.  If security can only be solved via a bounce buffer, who cares?  If
the user created themselves a non-aligned file to open O_DIRECT, that's
their problem if the last part-sector is negligably slower.

Joel

-- 

Life's Little Instruction Book #3

	"Watch a sunrise at least once a year."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
