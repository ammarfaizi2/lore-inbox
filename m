Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154535AbPHKLDH>; Wed, 11 Aug 1999 07:03:07 -0400
Received: by vger.rutgers.edu id <S153996AbPHKKOk>; Wed, 11 Aug 1999 06:14:40 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:31813 "EHLO pneumatic-tube.sgi.com") by vger.rutgers.edu with ESMTP id <S160342AbPHKHHY>; Wed, 11 Aug 1999 03:07:24 -0400
From: kanoj@google.engr.sgi.com (Kanoj Sarcar)
Message-Id: <199908110706.AAA09890@google.engr.sgi.com>
Subject: Re: linux+large database question
To: masp0008@stud.uni-sb.de
Date: Wed, 11 Aug 1999 00:06:51 -0700 (PDT)
Cc: kanoj@kulten.engr.sgi.com, linux-kernel@vger.rutgers.edu
In-Reply-To: <37AF64FA.5B3CFF1B@colorfullife.com> from "Manfred Spraul" at Aug 10, 99 01:32:10 am
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> 
> I read that you/SGI made benchmarks with Oracle and 4 MB page tables, so
> I hope that you can aswer some of these question:
>

No benchmarks yet, but we are scrambling to get something going soonest. 
At this point, the 4Mb page is just experimental, we are trying out a
bunch of other features which hold more promise (according to Oracle 
developers).

I sent your query out to a broad group of people inside SGI and Oracle,
since I personally do not have much experience with Oracle. What
follows is a compilation of the responses I received.

 
> What's the typical file layout for a large database, and how is the
> database accessed?

There are many different ways to lay out a database, and the methods
are different for various workloads and each RDBM (e.g. oracle, sybase,
informix, etc.)

In oracle, there are three main types of file:

        Control File(s)         - Contain database metadata
        Data Files(s)           - Contains data, data dictionary,
                                  temp tablespace (for 'sort by', 'group by'
                                  and 'order by' operations).
        Rollback Segments(s)    - Used for two-phase commit recovery, etc.

Some number (one or more) datafiles are concatenated into a single
tablespace, and a database consists one or more tablespaces.   Roll-back
segments are used for database updates and can consists of one or more
files.

The Database Administrator lays out the data in the database to suit
the needs of the application(s) which use the database.   Typically,
there will be a tablespace for the actual data tables, a  tablespace
for temp tables (used for sorting/grouping) and a tablespace for indicies
(which may be [re]created frequently).  Tablespace files are often
raw devices for performance reasons.

The ability for the operating system to stripe a single file across
multiple spindles (e.g. via VxVM, XVM, MD, or LVM) provides administrative
relief (only one datafile in a tablespace rather than many) and distributes
the data more evenly across the set of spindles that make up the tablespace.

Control files are small, infrequently accessed files which usually
reside as regular files on standard filesystems.  You usually have
more than one for redundancy reasons (you lose the control file, you've
lost the database).

> i.e.
> * mostly mmap, or normal read/write calls?

On high-performance systems, this is done with asynchronous I/O
(e.g. lio_listio) to raw devices.

> * one huge file, or many independant files?

Varies.

> * do you know if some UNIXes support multiple outstanding read/write
> operations per file handle? Under Win32, I can store the file pointer in

A lot of unix'es support this for raw devices;  for regular files,
UNIX semantics require that read and write operations be serialized.

> an OVERLAPPED structure and send multiple parallel operations to the
> same handle. AFAIK, Linux doesn't support that.

If it is a striped file, you want to have operations in progress
to all spindles in the stripe-set at the same time; and having more
doesn't hurt performance any.

> * how many parallel read/write operation are attempted per file?
> Just one operation, or multiple operations [using multiple filp's?]?

A single lio_listio with a vector of up to 1024 separate aiocbs is typical
in large database installations.

> 
> I ask these questions because I try to find an acceptable synchonization
> for sys_read()/ sys_write()/ sys_ftruncate()/ O_APPEND. Currently
> [2.3.13], this is completely missing, and I'm not sure that i_sem is the
> correct sync object.
> 
> Regards,
> 	Manfred
> 

Yes, if nothing, you need synchronization to make sure that the inode size
is somehow protected against concurrent writes and truncates. You could 
also argue that it is best to adopt the the UNIX concept of serialization
of all reads and writes. Depending on specific benchmarks, a multi reader
single writer lock might also be suitable.

Let me know if you have more questions or if I can help you.

Thanks.

Kanoj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
