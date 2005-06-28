Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVF1OiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVF1OiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVF1OiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:38:02 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:18706 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261461AbVF1Ohl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:37:41 -0400
To: "Al Boldi" <a1426z@gawab.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kswapd flaw
References: <200506281352.QAA25851@raad.intranet>
From: Nix <nix@esperi.org.uk>
X-Emacs: the prosecution rests its case.
Date: Tue, 28 Jun 2005 15:37:26 +0100
In-Reply-To: <200506281352.QAA25851@raad.intranet> (Al Boldi's message of
 "Tue, 28 Jun 2005 16:52:00 +0300")
Message-ID: <871x6m5yzd.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Al Boldi wrote:
> Hi Nix, how are you?
> You wrote: {
> On 28 Jun 2005, Al Boldi yowled:
>> Please do flush anytime, and do it in sync during OOMs; but don't 
>> evict procs especially not RUNNING procs, that is overkill.
> 
> Would you really like a system where once something was faulted in, it could
> never leave? You'd run out of memory *awfully* fast.
> }
> 
> You should only fault if you have a place to fault to, as into a swap.
> Without swap faulting is overkill.

That's `swapping', i.e. writing out dirty data pages (and text pages
dirtied by e.g. relocation) which otherwise have nowhere to go.

Pages mapped from files with read-only mappings and non-dirty pages of
read-write mappings get discarded when memory is tight; pages mapped
with read-write non-private maps and which have been modified get
written back to their file and discarded in the same situation.

(Private modified read-write mappings of data files have to stay in
memory: the only place they could go is swap, and there is none.)

> Is it possible to change kswapd's default behaviour to not fault if
> there is no swap?

I don't think so, except on a process-by-process basis via mlockall().
(/proc/sys/vm/swappiness lets you say that swapping is more or less
desirable, but under enough memory pressure paging *will* happen
regardless of the value of that variable.)

You can kludge it to some extent by putting your binaries in a tmpfs and
running from there: then you'll be paging from memory to memory ;)

But I'm mystified as to why you might want to suppress paging. The only
effect of suppressing it is to reduce the amount of memory you can
allocate before you run completely out and start killing things. Surely
slow execution is generally preferable to *no* execution?

(Or is it that you're trying to suppress *disk activity*, perhaps to
keep power consumption down? If so, running from tmpfs seems the best
option.)

-- 
`I lost interest in "blade servers" when I found they didn't throw knives
 at people who weren't supposed to be in your machine room.'
    --- Anthony de Boer
