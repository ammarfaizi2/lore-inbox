Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVJ3WZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVJ3WZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVJ3WZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:25:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16871 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932366AbVJ3WZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:25:52 -0500
Date: Sun, 30 Oct 2005 22:25:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
Message-ID: <20051030222543.GN7992@ftp.linux.org.uk>
References: <5455.1130484079@kao2.melbourne.sgi.com> <20051028073049.GA27389@redhat.com> <1130710531.32734.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130710531.32734.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 10:15:31PM +0000, Alan Cox wrote:
> gcc is a *LOT* smarter than you give it credit for. It will not warn for
> cases where it isn't able to tell how foo is used passed with &foo. It
> will warn for cases where it can

static inline __attribute__((always_inline)) int bar(int n, int *idx)
{
        if (n != 1) 
                return 0; 
        *idx = 1;
        return 1;  
}
void baz(int *v, int n)
{
        int idx;
        int p = bar(n, &idx);
        if (__builtin_expect(!p, 0))
                return; 
        *v |= idx;
}

and try gcc -Wall on that.  Watch it warn about idx being possibly
uninitialized.  Replace __builtin_expect(!p, 0) with !p and see
the warning go away.  That, BTW, is a trimmed-down source of bogus
warning in bio.c.  And a lot of its analogs all over the tree.
