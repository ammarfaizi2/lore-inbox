Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317604AbSHHPd7>; Thu, 8 Aug 2002 11:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSHHPd6>; Thu, 8 Aug 2002 11:33:58 -0400
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:20635 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP
	id <S317604AbSHHPd6>; Thu, 8 Aug 2002 11:33:58 -0400
Date: Thu, 8 Aug 2002 10:37:27 -0500 (CDT)
Message-Id: <200208081537.KAA09749@radium.lmcg.wisc.edu>
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
CC: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>,
       "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'pollard@tomcat.admin.navo.hpc.mil'" 
	<pollard@tomcat.admin.navo.hpc.mil>,
       "'bcrl@redhat.com'" <bcrl@redhat.com>,
       "'cks@utcc.utoronto.ca'" <cks@utcc.utoronto.ca>
In-reply-to: <EE83E551E08D1D43AD52D50B9F511092E114E5@ntserver2> (message from
	Gregory Giguashvili on Thu, 8 Aug 2002 16:57:59 +0200)
Subject: Re: O_SYNC option doesn't work (2.4.18-3)
Reply-to: Daniel Forrest <forrest@lmcg.wisc.edu>
References: <EE83E551E08D1D43AD52D50B9F511092E114E5@ntserver2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

>> The above sequence works OK, but it's still problematic since it
>> doesn't ensure that the data is coming from the server instead of
>> NFS cache. In one of my previous discussions on this list, I was
>> told to use the following technique to flush NFS buffers. It turns
>> out that acquiring write lock using fcntl (F_SETLK) interface acts
>> as NFS write barrier and flushes all the file NFS buffers. So, the
>> above sequence would result in the following one:
>> 
>> - lock_file (doesn't have to be a lockd lock)
>> - open_file (O_SYNC)
>> - if (read) fcntl (F_SETLK) (doing lock/unlock here to flush NFS buffers)
>> - read/write file
>> - if (write) fcntl (F_SETLK) (doing lock/unlock here to flush NFS buffers)
>> - close_file
>> - unlock_file

I have been working in a mixed Linux/Solaris environment and this is
what works for me.  (>40 machines reading/writing/modifying the same
files at the same time for hundreds of iterations with no errors.)

- open()

  To get a file descriptor that can be locked

- fcntl(F_SETLK)

  To ensure that all other clients have written their data to the file
  and to clear the client cache

- fchmod()

  File attributes (most importantly file size) were cached when the
  file was opened, these may change between that time and when the
  lock is granted, a side effect of fchmod() is to refresh the file
  attributes from the server

- lseek() / read() / write()

  If appending, it is important to lseek(SEEK_END) at this point to
  make sure you are at the true end of file

- close()

  This will flush any data written and remove the lock


If anyone experiments with this with systems other than Linux/Solaris
I would be interested in knowing if it works there also.

-- 
+----------------------------------+----------------------------------+
| Daniel K. Forrest                | Laboratory for Molecular and     |
| forrest@lmcg.wisc.edu            | Computational Genomics           |
| (608)262-9479                    | University of Wisconsin, Madison |
+----------------------------------+----------------------------------+
