Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRKKHhZ>; Sun, 11 Nov 2001 02:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280993AbRKKHhP>; Sun, 11 Nov 2001 02:37:15 -0500
Received: from ns.suse.de ([213.95.15.193]:54288 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280984AbRKKHg4>;
	Sun, 11 Nov 2001 02:36:56 -0500
Date: Sun, 11 Nov 2001 08:36:50 +0100
From: Thorsten Kukuk <kukuk@suse.de>
To: linux-kernel@vger.kernel.org, Heinz.Mauelshagen@t-online.de
Subject: Re: Bug in /proc/lvm/global (garbage printed)
Message-ID: <20011111083649.A9442@suse.de>
In-Reply-To: <20011110120619.A10459@suse.de> <20011110175507.L1778@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011110175507.L1778@lynx.no>; from adilger@turbolabs.com on Sat, Nov 10, 2001 at 05:55:07PM -0700
Organization: SuSE GmbH, Nuernberg, Germany
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, Andreas Dilger wrote:

> On Nov 10, 2001  12:06 +0100, Thorsten Kukuk wrote:
> > The problem is in the _proc_read_global function. This function does
> > not use the "page" parameter to return the data. Instead it allocates
> > it's own buffer and change to "start" parameter to point to it.
> > 
> > --- drivers/md/lvm-fs.c	2001/11/09 19:00:38	1.1
> > +++ drivers/md/lvm-fs.c	2001/11/09 20:50:16
> > @@ -482,11 +480,15 @@
> >  		buf = NULL;
> >  		return 0;
> >  	}
> > -	*start = &buf[pos];
> > -	if (sz - pos < count)
> > +	/* *start = &buf[pos]; */
> > +	if (sz - pos < count) {
> > +		memcpy (page, &buf[pos], sz - pos);
> >  		return sz - pos;
> > -	else
> > +        }
> > +	else {
> > +		memcpy (page, &buf[pos], count);
> >  		return count;
> > +	}
> >  
> >  #undef LVM_PROC_BUF
> >  }
> 
> What version of LVM do you have?  This code looks different than mine.
> The file lvm-fs.c does not exist in Linus kernels, only in patched kernels.

This is from LVM 1.0.1-rc4. But all previous versions have the same
problem, the function here is lvm_proc_get_global_info() in 
drivers/md/lvm.c. The fix is also the same.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE GmbH            Deutschherrenstr. 15-19       D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B
