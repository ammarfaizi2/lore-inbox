Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVCIJvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVCIJvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 04:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVCIJvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 04:51:50 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:63641 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262211AbVCIJvr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 04:51:47 -0500
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: "pbadari@us.ibm.com" <pbadari@us.ibm.com>, Daniel McNeil <daniel@osdl.org>,
       "suparna@in.ibm.com" <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309040757.GY27331@ca-server1.us.oracle.com>
References: <1110189607.11938.14.camel@frecb000686>
	 <20050307223917.1e800784.akpm@osdl.org> <20050308090946.GA4100@in.ibm.com>
	 <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
	 <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
	 <1110324434.6521.23.camel@ibm-c.pdx.osdl.net>
	 <1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com>
	 <20050309040757.GY27331@ca-server1.us.oracle.com>
Date: Wed, 09 Mar 2005 10:50:59 +0100
Message-Id: <1110361859.14594.44.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/03/2005 11:00:53,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/03/2005 11:00:56,
	Serialize complete at 09/03/2005 11:00:56
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 08 mars 2005 à 20:07 -0800, Joel Becker a écrit :
> On Tue, Mar 08, 2005 at 03:54:04PM -0800, Badari Pulavarty wrote:
> > > 1. return EINVAL if the DIO goes past EOF.
> > > 
> > > 2. truncate the request to file size (which is what your patch does)
> > >     and if it works, it works.
> > > 
> > > 3. truncate the request to a size that actually works - like a multiple
> > >     of 512.
> > > 
> > > 4. Do the full i/o since the user buffer is big enough, truncate the
> > >     result returned to file size (and clear out the user buffer where it
> > >     read past EOF).
> > > 
> > > Number 4 would make it easy on the user-level code, but AIO DIO might be
> > > a bit tricky and might be a security hole since the data would be dma'ed
> > > there and then cleared.  I need to look at the code some more.
> 
> 	Solaris, which does forcedirectio as a mount option, actually
> will do buffered I/O on the trailing part.  Consider it like a bounce
> buffer.  That way they don't DMA the trailing data and succeed the I/O.
> The I/O returns actual bytes till EOF, just like read(2) is supposed to.
> 	Either this or a fully DMA'd number 4 is really what we should
> do.  If security can only be solved via a bounce buffer, who cares?  If
> the user created themselves a non-aligned file to open O_DIRECT, that's
> their problem if the last part-sector is negligably slower.
> 
> Joel
> 

  From a user's perspective, I tend to agree with Joel. A read going
past EOF should IMHO return the data till EOF and reflect it in the
return value. The penalty incured by the trailing part going buffered
is the price to pay for not having a fully aligned file.

  I think doing otherwise would break read(2) semantics.

  Sébastien.

------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

