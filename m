Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVCHJsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVCHJsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVCHJrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:47:37 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39822 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261934AbVCHJrb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:47:31 -0500
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: "linux-aio kvack.org" <linux-aio@kvack.org>, linux-kernel@vger.kernel.org,
       pbadari@us.ibm.com, suparna@in.ibm.com
Date: Tue, 08 Mar 2005 10:46:42 +0100
Message-Id: <1110275202.14594.25.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/03/2005 10:56:35,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/03/2005 10:56:36,
	Serialize complete at 08/03/2005 10:56:36
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 08 mars 2005 à 01:18 -0800, Andrew Morton a écrit :
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > ...
> > 
> > Bugs in this area seem never-ending don't they - plug one, open up
> > another - hard to be confident/verify :( - someday we'll have to
> > rewrite a part of this code.
> 
> It's solving a complex problem.  Any rewrite would probably end up
just as
> hairy once all the new bugs and corner cases are fixed.  Maybe.
> 
> 
> > Hmm, shouldn't dio->result ideally have been adjusted to be within
> > i_size at the time of io submission, so we don't have to deal with
> > this during completion ? We are creating bios with the right size
> > after all. 
> > 
> > We have this: 
> >             if (!buffer_mapped(map_bh)) {
> >                             ....
> >                             if (dio->block_in_file >=
> >
i_size_read(dio->inode)>>blkbits) {
> >                                         /* We hit eof */
> >                                         page_cache_release(page);
> >                                         goto out;
> >                                 }
> > 
> > and
> >             dio->result += iov[seg].iov_len -
> >                         ((dio->final_block_in_request -
dio->block_in_file) <<
> >                                         blkbits);
> > 
> > 
> > can you spot what is going wrong here that we have to try and
> > workaround this later ?
> 
> Good question.  Do we have the i_sem coverage to prevent a concurrent
> truncate?
> 
> But from Sebastien's description it doesn't soound as if a concurrent
> truncate is involved.

Yes, you're right, there's no concurrent truncate here. My test case
as well as Daniel's is single threaded and is the only thread accessing
the file.

Regards,

Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

