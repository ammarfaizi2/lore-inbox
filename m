Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVHWHfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVHWHfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVHWHfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:35:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3300 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750800AbVHWHfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:35:51 -0400
Date: Tue, 23 Aug 2005 13:14:38 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       jakub@redhat.com, akpm@osdl.org
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Linux AIO status & todo
Message-ID: <20050823074438.GA4586@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo suggested putting together a summary note describing the status (e.g.
pending out-of-tree patches) and TODO items that need fixing in the mainline
linux kernel AIO implementation to get good AIO support in both kernel-space
and user-space, starting with enabling reasonably efficient and compliant
POSIX AIO on top of kernel AIO. Since Sébastien is on a longish leave, I
thought I'd go ahead and post it anyway and refine it along the way, rather
than delay the discussion further. So here is a first-cut attempt for
review and feedback. 

Thoughts ?

Ulrich,
This doesn't go as far as addressing the blue-sky section of your posix
aio requirements list, but I think it tries to cover some of the major issues.
Do you see anything significant that is missing here ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


		       Linux kernel AIO Status/Todo
		       ----------------------------

Put together by Sébastien Dugué <sebastien.dugue@bull.net> with 
inputs and additions from Ben LaHaise <bcrl@kvack.org, bcrl@linux.intel.com>
and Suparna Bhattacharya <suparna@in.ibm.com>.

				   
1. Linux kernel 2.6.13 AIO support
----------------------------------

  The current 2.6.13 kernel native AIO infrastructure allows implementation of
only a subset of the POSIX AIO API.

  Currently the restrictions are:

	1. AIO support is only provided for files opened with O_DIRECT and
	   when the user buffer and size are block aligned. This means that IO
	   requests going through the page cache are still synchronous if the
	   pages are not in the cache.

	2. No support for propagating IO completion events to user space
	   threads using RT signals. User threads need to poll the completion
	   queue using io_getevents. POSIX specifies that when an AIO
	   request completes, a signal can be delivered to the application
	   to indicate the completion of the IO.

	3. No support for listio completion notification. POSIX specifies that
	   if the lio_listio mode is LIO_NOWAIT then asynchronous notification
	   shall occur upon completion of all the IOs on the list.

	4. No support for listio LIO_WAIT. POSIX specifies that
	   if the lio_listio mode is LIO_WAIT then the caller blocks
	   until completion of all the IOs on the list.

	5. No support for prioritized IO - aio_reqprio field of the aiocb.

	6. No support for cancelation against a file descriptor. POSIX
	   specifies that if the aiocb argument to aio_cancel is NULL then
	   all cancelable AIO requests against the file descriptor shall be
	   canceled.

	7. Cancellation of iocbs is not implemented (the infrastructure exists
	   but cancel methods haven't been implemented yet for supported
	   AIO operations, so cancellation returns -EAGAIN)

	8. No support for aio_fsync.

	9. AIO on sockets is not implemented and exhibits synchronous
	   behaviour

	10.No support for AIO on pipes

  An implementation of Linux POSIX AIO using kernel AIO, authored by
  Laurent Vivier and Sébastien Dugue is available at:
  http://www.bullopensource.org/posix. 

  The implementation uses a single ioctx for all POSIX AIO requests,
  avoiding the need to wait on multiple contexts for aio_suspend, and
  can take advantage of additional kernel patches described below for
  providing more complete and efficient POSIX AIO.

  Pradeep Padala (<ppadala@eecs.umich.edu>) mentioned that he is working
  toward some glibc patches based on the above implementation.

2. Additional support provided by patches
-----------------------------------------

  Kernel patches add some missing functionality previously described.


  2.1. Buffered filesystem AIO (#1)
  ----------------------------

	This is addressed by Suparna's patches for buffered filesystem AIO.


  2.2. AIO completion sigevent (#2)
  -------------------------

	This is addressed by Laurent and Sébastien's aioevent patch,
	with modifications from Ben LaHaise. It adds an
	aio_sigevent struct to the iocb. The relevant fields of the sigevent
	(pid, signal number, notification type and value) are extracted and
	stored in the kiocb for use upon request completion.

	The sigevent structure is filled in by the user application as part of
	an AIO request preparation. Upon request completion, the kernel notifies
	the application using those sigevent parameters. If SIGEV_NONE has been
	specified then the old behavior is retained and the application must
	rely on polling the completion queue.


  2.3 Listio completion event (#3)
  ---------------------------

	There are a few alternative approaches under consideration to address
	this:

	(a) IOCB_CMD_EVENT marker iocbs
	Laurent's and Sébastien's lioevent patch introduces an
	IOCB_CMD_EVENT command. As part of listio submission,
	userspace creates an empty special request with an aio_lio_opcode of
	IOCB_CMD_EVENT filling up only the aio_sigevent fields.
	The purpose of IOCB_CMD_EVENT is to group together the following
	requests in the list up to the end of the list (or up to the next
	IOCB_CMD_EVENT request in the list).

	In sys_io_submit, upon detecting such a marker iocb, an lio_event is
	created which contains the necessary information for
	signaling a thread (signal number, pid, notify type and value) along
	with a count of requests attached to this event.
	Each subsequent submitted request is attached to this lio_event by
	setting the request kiocb to that lio_event. When all the requests
	in the group have completed then aio_complete() knows that it is time
	to signal the user process.

	(b) IOCB_CMD_GROUP for submitting a group of iocbs
	This approach introduces a new IOCB_CMD_GROUP command iocb, which
	takes as an argument a group of iocbs which must be submitted and
	completed before marking the IOCB_CMD_GROUP iocb complete (the
	argument may be passed in as a user-space buffer to be copied in).
	Internally a struct kiocb *ki_liocb is added to the kiocb structure,		to link the individual iocbs with the group command iocb, so that an
	aio_complete() can be issued on the latter when all the iocbs in
	the group are done. Upon request completion of the IOCB_CMD_GROUP
	iocb, the kernel notifies the application using its corresponding
	sigevent parameters. [Status: Patch to be developed]

	(c) A new io_submit_group() or lio_submit() syscall
	Similar to (b), but using an explicit system call.


  2.4. Listio LIO_WAIT (#4)
  --------------------

	Alternative approaches under consideration include:
	(a) IOCB_CMD_CHECKPOINT marker iocbs
	Laurent's and Sébastien's liowait patch adds support for an in-kernel
	POSIX listio LIO_WAIT mechanism. This works by adding an
	IOCB_CMD_CHECKPOINT command and builds upon the lioevent
	patch described in 2.3(a). As part of listio submission, userspace
	prepends an empty iocb to the list with an aio_lio_opcode of
	IOCB_CMD_CHECKPOINT. All iocbs following this particular CHECKPOINT
	iocb are in the same group and sys_io_submit will block until all
	iocbs submitted in the group have completed.

	The behavior is similar to IOCB_CMD_EVENT. In sys_io_submit, upon
	detecting such a marker iocb, an lio_event is created.
	Each subsequent submitted request is attached to this lio_event by
	setting the request kiocb to that lio_event (in io_submit_one) and
	incrementing the lio_users count.

	(b) IOCB_CMD_GROUP with min_nr wakeup in io_getevents
	An io_submit() with IOCB_CMD_GROUP as described in 2.3(b) with
	SIGEV_NONE followed by a call to io_getevents() requesting a
	single wakeup for min_nr events (patch from Ben LaHaise) can
	help make LIO_WAIT implementation reasonably efficient.
	


  2.5 AIO cancellation against a file descriptor (#6)
  ---------------------------------------------

	Laurent's and Sébastien's cancelfd patch implements this by
	walking the list of active requests queued onto an IO context and trying
	to cancel all those requests related to the given file descriptor.
	This doesn't scale well under the presence of thousands of iocbs to
	several files. A better solution (as suggested by Ben LaHaise) would
	be maintain a list of iocbs in struct file, which would also be
	useful for getting the queueing semantics correct for network AIO
	when it is implemented. [Status: Patch to be developed]

  2.6 AIO for pipes (#10)
  -----------------

	Chris Mason had a patch to support AIO for pipes; more recently
	Ben LaHaise's git tree includes a pipe AIO implementation which is 
	based on his patches for async semaphore support

  2.7 Thread based fallback for unimplemented AIO operations (#8 etc)
 ------------------------------------------------------------

	Ben LaHaise has a patch for an in-kernel thread based fallback using
	regular synchronous IO for AIO operations that have not been 
	implemented as yet, as an interim measure while AIO gets extended
	more widely to additional methods like aio_fsync and drivers like
	sound. This enables user space application development to proceed
	independently of asyncification for more methods.


  2.8 Additional Features (beyond POSIX)
 ---------------------------------------
	
	- Vector AIO patches aka AIO readv, writev (from Zach Brown)
		Currently included in Ben's git tree

	- Patches for epoll notification through AIO (Zach Brown/Feng Zhou/wli)
		Needs benchmarking and reposting with updates

3. Work to do
-------------------

	- Make the existing max aio events limit a ulimit

	- Add support for prioritized IO (#5). This is optional for AIO if
	  POSIX_PRIORITIZED_IO is not defined, but mandatory for Realtime
	  profiles.

	  Work is currently going on to add IO priority support to the CFQ IO
	  scheduler (2 new syscalls). This could be used to map AIO priority
	  levels onto the scheduler priority levels provided the CFQ elevator
	  is used.

	- Implement IO requests cancelation support at the fs level (#7), for
	  various operations.

	- Implement AIO for network sockets (#9)
	
	- Implement asynchronous fsync at the fs level (#8).

	- Spread AIO to more drivers etc

