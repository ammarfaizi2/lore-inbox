Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbWJJV6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbWJJV6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWJJV6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:58:42 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:46676 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030561AbWJJV6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:58:32 -0400
Date: Tue, 10 Oct 2006 14:58:08 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Paul Menage <menage@google.com>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061010215808.GK7911@ca-server1.us.oracle.com>
Mail-Followup-To: Paul Menage <menage@google.com>,
	Chandra Seetharaman <sekharan@us.ibm.com>, akpm@osdl.org,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 02:31:43PM -0700, Paul Menage wrote:
> >        NAK.  This forces a complex and inappropriate interface on the
> >majority of users, and doesn't honor configfs' simplicity-first design.
> 
> How is the seq_file interface complex and inappropriate? For the
> configfs clients it's basically a drop-in replacement for sprintf(),
> as Chandra's patches show.

	Well, they now have to learn seq_file.  They now get to assume
that "spewing large amounts of junk" is the default rather than "single
attribute", which is correct.  None of it is relevant for the majority
of correct users.
	It exposes the "I'm a file" knowledge down to the client module.
The entire point of configfs is that the "filesystem bits" are
independant of the "client bits".  To the client, it's an item
hierarchy.  To the user, the interface happens to be a filesystem.
	Technically, the seq_printf() as a drop-in replacement seems to
be functional.  I'm worried about lifetiming, but I think it's OK (what
do I mean?  If I open the file, I'd better not be able to remove the
client module until everything is torn down.  If I close the file, it
had better get all torn down before module_put() so that when
->release() returns, te module can safely be removed.  I *think* this
change satisfies these worries, but it's something that absolutely has
to be done right.  Yes, I'm very paranoid about this).
	My bigger worry is that we haven't solved the write side.  How
does one *set* a large attribute?  It had better not be multiple
attributes.  I know that your module doesn't set it, but hey, we don't
codify that requirement.  Perhaps a patch where we say "if you are a
large display attribute, we'll use seq_file and error on write because
it isn't allowed" but that leaves the old buffer-based approach for
normal-sized read-write attributes.

Joel

-- 

Life's Little Instruction Book #252

	"Take good care of those you love."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
