Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTBKN5D>; Tue, 11 Feb 2003 08:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267856AbTBKN5D>; Tue, 11 Feb 2003 08:57:03 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:38164 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267853AbTBKN5C>;
	Tue, 11 Feb 2003 08:57:02 -0500
Message-ID: <3E490374.1060608@mvista.com>
Date: Tue, 11 Feb 2003 08:06:44 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com> <20030211191027.A2999@in.ibm.com>
In-Reply-To: <20030211191027.A2999@in.ibm.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Suparna Bhattacharya wrote:

|
|For the sort of problems which Ken is seeing, maybe we can,
|for a start, do without all the modifications to make the
|new kernel run at a different address, if we can assume
|that most i/o is likely is happen on dynamically allocated
|buffers.
|
|We could just reserve a memory area of reasonable size (how
|much ?) which would be used by the new kernel for all its
|allocations. We already have the infrastructure to tell the
|new kernel which memory areas not to use, so its simple
|enough to ask it exclude all but the reserved area.
|By issuing the i/o as early as possible during bootup
|(for lkcd all we need is the block device to be setup for
|i/o requests), we can minimize the amount of memory to
|reserve in this manner.

DMA can occur almost anywhere.  If you restrict the area of DMA, that
means you have to copy the contents to the final destination.  I don't think
we want to do that in many cases.

|
|That might address a large percentage of the regular cases,
|i.e. except where statically allocated buffers could be
|targets for DMA. If we are using in-use (user) pages
|for saving the dump, then there is a possibility of a dump
|getting corrupted by a DMA, but there may be a way to
|minimize that when we chose destination pages to use.

Unless you have some way to mark pages as current DMA targets, you,
you won't be able to do this.  And the problem Ken and I are seeing is
happening after the new kernel has booted. An old DMA operation is
occuring after the new kernel has booted.  That means two kernels would
have to choose the same DMA target areas, and that's fairly unreasonable
to ask, IMHO.

The only reasonable way I can think of to do this is to quiesce the devices
before dumping memory or doing a kexec.  It's not that hard to do, it's just
that a lot of DMA capable device drivers exist that don't do this.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+SQNzmUvlb4BhfF4RAnboAJ4rOL+Amh8F1EvahT9Uko/Y6tPXRwCfV2su
0g582Xllh4TGZ7wQ2YJSsDg=
=FaLb
-----END PGP SIGNATURE-----


