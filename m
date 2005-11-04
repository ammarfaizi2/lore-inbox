Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbVKDDKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbVKDDKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVKDDKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:10:16 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:15021 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161121AbVKDDKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:10:14 -0500
Date: Fri, 4 Nov 2005 04:10:13 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: do_sendfile ppos check ...
Message-ID: <20051104031012.GD22020@MAIL.13thfloor.at>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20051103175642.GB18015@MAIL.13thfloor.at> <E1EXrRU-0006eK-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EXrRU-0006eK-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 01:36:36PM +1100, Herbert Xu wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> > 
> > which passes ppos as NULL, which in turn leads to an oops ...
> 
> But do_sendfile will set ppos to &in_file->f_pos if it's NULL.
> Why isn't that working?
> 
> > @@ -731,7 +731,8 @@ asmlinkage ssize_t sys_sendfile(int out_
> >                return ret;
> >        }
> > 
> > -       return do_sendfile(out_fd, in_fd, NULL, count, 0);
> > +       pos = 0;
> > +       return do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
> > }
> 
> The last argument is meant to be zero if you check the history.

hmm, why a different max than with offset?

currently investigating ... probably a removal of
the 'unnecessary' check (*ppos) would be a better
approach, something like:

--- linux-2.6/fs/read_write.c   2005-10-28 23:59:02.000000000 +0200
+++ linux-2.6/fs/read_write.c   2005-11-03 17:28:50.000000000 +0100
@@ -719,9 +719,6 @@
       	current->syscr++;
       	current->syscw++;

-       if (*ppos > max)
-               retval = -EOVERFLOW;
-
 fput_out:
         	ds,   fput_light(out_file, fput_needed_out);
 fput_in:

thanks for the input,
Herbert

> 
> Cheers,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
