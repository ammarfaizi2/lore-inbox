Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUDQTTV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUDQTTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:19:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5125 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263927AbUDQTTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:19:19 -0400
Date: Sat, 17 Apr 2004 20:19:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040417201914.B21974@flint.arm.linux.org.uk>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
References: <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea> <1082228313.2580.25.camel@lade.trondhjem.org> <20040417190107.GA4179@flea> <1082228963.2580.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1082228963.2580.34.camel@lade.trondhjem.org>; from trond.myklebust@fys.uio.no on Sat, Apr 17, 2004 at 12:09:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 12:09:24PM -0700, Trond Myklebust wrote:
> On Sat, 2004-04-17 at 12:01, Marc Singer wrote:
> 
> > I think you are talking about the fstab mount option.  Is there a
> > kernel command line option for this?  That's what I've been looking
> > for.  I'm not using an initrd.
> 
> No. I'm talking about the built-in parser to enable NFSROOT to pass
> mount options. As in:
> 
>    nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
> 
> See Documentation/nfsroot.txt. Put "tcp" as one of the "<nfs-options>",
> and your root partition will use TCP instead of UDP.

Trond,

Can you explain how this works?

static int __init root_nfs_parse(char *name, char *buf)
{
...
        while ((p = strsep (&name, ",")) != NULL) {
                int token;
                if (!*p)
                        continue;
                token = match_token(p, tokens, args);

                /* %u tokens only */
                if (match_int(&args[0], &option))
                        return 0;

Firstly, as far as I can see, args[] is uninitialised.  If match_token
doesn't touch args[] then we pass match_int some uninitialised kernel
memory.

Secondly, we seem to exit if match_int doesn't parse a number.  Not
all options in "tokens" have a number associated with them, including
ones like "tcp".

So, given that "tcp" is the only option, I think we'll end up passing
match_int() some uninitialised memory which may cause a kernel oops.
If not, it probably won't be a valid number, so we'll ignore the option.

However, it will appear to work as long as the first option has a
number associated with it (ie, is one of the first 9 options.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
