Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSANF5Y>; Mon, 14 Jan 2002 00:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288802AbSANF5L>; Mon, 14 Jan 2002 00:57:11 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:8719 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288809AbSANF46>; Mon, 14 Jan 2002 00:56:58 -0500
Date: Mon, 14 Jan 2002 08:56:56 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] [PATCH] corrupted reiserfs may cause kernel to panic on lookup() sometimes.
Message-ID: <20020114085656.A4491@namesys.com>
In-Reply-To: <20020103101830.A2610@namesys.com> <147220000.1010771186@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147220000.1010771186@tiny>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 11, 2002 at 12:46:26PM -0500, Chris Mason wrote:

> >     Certain disk corruptions and i/o errors may cause lookup() to panic,
> > which is wrong.     This patch fixes the problem.
> >     Please apply.
> Hmmm, none of the callers of reiserfs_find_entry have been changed to check
> for IO_ERROR.  We should at least change reiserfs_add_entry to check for
> IO_ERROR, so it doesn't try to create a name after getting io error during
> the lookup.
Well, in fact reiserfs_add_entry won't do that anyway, consider this code:
    retval = reiserfs_find_entry (dir, name, namelen, &path, &de);
    if( retval != NAME_NOT_FOUND ) {
        if (buffer != small_buf)
            reiserfs_kfree (buffer, buflen, dir->i_sb);
        pathrelse (&path);

        if (retval != NAME_FOUND) {
            reiserfs_warning ("zam-7002:" __FUNCTION__ ": \"reiserfs_find_entry\" has returned"
                              " unexpected value (%d)\n", retval);
       }

        return -EEXIST;
    }

Though I see other places where code is not that smart. I'll come up with additional patch later today.
Thanks for noticing.

Bye,
    Oleg
