Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUKCVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUKCVWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUKCVUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:20:24 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:36254 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261891AbUKCVPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:15:37 -0500
Message-ID: <41894FC0.6080609@drdos.com>
Date: Wed, 03 Nov 2004 14:38:08 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jeff Garzik <jgarzik@pobox.com>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au>	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>	 <4187F69E.9020604@drdos.com> <1099431477.7854.21.camel@lade.trondhjem.org>	 <20041102225304.GA11441@galt.devicelogics.com> <41882414.2070003@drdos.com> <1099444402.9957.8.camel@lade.trondhjem.org> <41890D5F.4000006@drdos.com>
In-Reply-To: <41890D5F.4000006@drdos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

> Trond Myklebust wrote:
>
>>
>>>> Connect 2.4.18 and 2.6.9 with NFS 3 enabled.  I am seeing problems 
>>>> connecting and file size mismatches.  I also see errors with zero
>>>> length files (host side) that get opened and populated with data
>>>> and the remote side is unable to read them -- keeps seeing them as 
>>>> zero length.      
>>>
>>
>> That's entirely expected. NFS has always been forced to use a polling
>> model for attribute cache consistency. "man 5 nfs" and read all about
>> the "actimeo" mount options that control this behaviour.
>>
>> Cheers,
>>  Trond
>>
>>  
>>
> Trond,
>
> Thanks for the update.  I noticed from another post on this thread 
> that the problems with
> /etc/exports are being addressed.  This was the other problem I was 
> seeing but it appears
> to be getting fixed.
>
> Jeff
>
>
>
Trond,

While you are running down this problem, I've located another odd 
behavior you
may (or may not) chose to address.  In my dsfs file system, I use sector 
runs (large ones)
that can sometimes return odd sizes during running down a file for 
reading. 

i.e.  I can return 4096,4096,4096,512,1024,4096,4096 block sizes on size 
returns
from vfs_read() for 512 or 4096 block requests when the file is read 
sequentially. 
Under NTFS and other OS architectures, unless the final read attempt 
returns 0 size
denoting end of file, this seems to be allowed.  I noticed that all of 
the linux code with
the exception of NFS also handles this situation quite nicely.  NFS does 
not.  I have
noted that if NFS receives a read size smaller than the requested block, 
it always assumes
end of file and terminates the next read.  I hace modified dsfs to 
always return
block sizes in a uniform manner so NFS will work properly, even though 
the rest
of the Linux apps work just fine without assuming the end of file has 
been reached. 

I personally think this is a broken behavior, but perhaps it's in line 
with some NFS
spec somewhere.  I have coded around it, but thout I would mention it to
you.

Jeff



