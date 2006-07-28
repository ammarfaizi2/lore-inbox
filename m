Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWG1M6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWG1M6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWG1M6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:58:32 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38070 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030223AbWG1M6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:58:30 -0400
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>
	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>
	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>
	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686>
	 <44C8DB80.6030007@us.ibm.com>  <44C9029A.4090705@oracle.com>
	 <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
	 <44C90987.1040200@redhat.com>
	 <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
Date: Fri, 28 Jul 2006 14:58:20 +0200
Message-Id: <1154091500.13577.14.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2006 15:03:08,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2006 15:03:08,
	Serialize complete at 28/07/2006 15:03:08
Content-Type: multipart/mixed; boundary="=-5x10Zz0yOl41ppCZ1U7e"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5x10Zz0yOl41ppCZ1U7e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

On Thu, 2006-07-27 at 14:02 -0700, Badari Pulavarty wrote:
> On Thu, 2006-07-27 at 11:44 -0700, Ulrich Drepper wrote:
> > Badari Pulavarty wrote:
> > > Before we spend too much time cleaning up and merging into mainline -
> > > I would like an agreement that what we add is good enough for glibc
> > > POSIX AIO.
> >=20
> > I haven't seen a description of the interface so far.  Would be good if
> > it existed.  But I briefly mentioned one quirk in the interface about
> > which Suparna wasn't sure whether it's implemented/implementable in the
> > current interface.
>=20
> Sebastien, could you provide a description of interfaces you are
> adding ? Since you did all the work, it would be appropriate for
> you to do it :)
>=20

  Here are the descriptions for the AIO completion notification and
listio patches. Hope I did not leave out too much.

  S=E9bastien.

--=20
-----------------------------------------------------

  S=E9bastien Dugu=E9                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

--=-5x10Zz0yOl41ppCZ1U7e
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=aioevent.txt
Content-Type: text/plain; name=aioevent.txt; charset=ISO-8859-15



		     aio completion notification

Summary:
-------

  The current 2.6 kernel does not support notification of user space via
an RT signal upon an asynchronous IO completion. The POSIX specification
states that when an AIO request completes, a signal can be delivered to
the application as notification.

  The aioevent patch adds a struct sigevent *aio_sigeventp to the iocb.
The relevant fields (pid, signal number and value) are stored in the kiocb
for use when the request completes.

  That sigevent structure is filled by the application as part of the AIO
request preparation. Upon request completion, the kernel notifies the
application using those sigevent parameters. If SIGEV_NONE has been specified,
then the old behaviour is retained and the application must rely on polling
the completion queue using io_getevents().

Details:
-------

  A struct sigevent *aio_sigeventp is added to struct iocb in
include/linux/aio_abi.h

  An enum {IO_NOTIFY_SIGNAL = 0, IO_NOTIFY_THREAD_ID = 1} is added in
include/linux/aio.h:

	- IO_NOTIFY_SIGNAL means that the signal is to be sent to the
	  requesting thread 

	- IO_NOTIFY_THREAD_ID means that the signal is to be sent to a
	  specifi thread.

  The following fields are added to struct kiocb in include/linux/aio.h:

	- pid_t ki_pid: target of the signal

	- __u16 ki_signo: signal number

	- __u16 ki_notify: kind of notification, IO_NOTIFY_SIGNAL or
			   IO_NOTIFY_THREAD_ID

	- uid_t ki_uid, ki_euid: filled with the submitter credentials

	- sigval_t ki_sigev_value: value stuffed in siginfo

  these fields are only valid if ki_signo != 0.

	

  In io_submit_one(), if the application provided a sigevent then
iocb_setup_sigevent() is called which does the following:

	- save current->uid and current->euid in the kiocb fields ki_uid and
	  ki_euid for use in the completion path to check permissions

	- check access to the user sigevent

	- extract the needed fields from the sigevent (pid, signo, and value).
	  If the signal number passed from userspace is 0 then no notification
	  is to occur and ki_signo is set to 0

	- check whether the submitting thread wants to be notified directly
	  (sigevent->sigev_notify_thread_id is 0) or wants the signal to be sent
	  to another thread.
	  In the latter case a check is made to assert that the target thread
	  is in the same thread group

	- fill in the kiocb fields (ki_pid, ki_signo, ki_notify and ki_sigev_value)
	  for that request.

  Upon request completion, in aio_complete(), if ki_signo is not 0, then
__aio_send_signal() is called which sends the signal as follows:

	- fill in the siginfo struct to be sent to the application

	- check whether we have permission to signal the given thread

	- send the signal

--=-5x10Zz0yOl41ppCZ1U7e
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lioevent.txt
Content-Type: text/plain; name=lioevent.txt; charset=ISO-8859-15


			    listio support


Summary:
-------
  
  The lio patch adds POSIX listio completion notification support. It builds
on support provided by the aio event patch and adds an IOCB_CMD_GROUP
command to sys_io_submit().

  The purpose of IOCB_CMD_GROUP is to group together the following requests in
the list up to the end of the list.

  As part of listio submission, the user process prepends to a list of requests
an empty special aiocb with an aio_lio_opcode of IOCB_CMD_GROUP, filling only
the aio_sigevent fields.



Details:
-------

  An IOCB_CMD_GROUP is added to the IOCB_CMD enum in include/linux/aio_abi.h

  A struct lio_event is added in include/linux/aio.h

  A struct lio_event *ki_lio is added to struct iocb in include/linux/aio.h


 In sys_io_submit(), upon detecting such an IOCB_CMD_GROUP marker iocb, an
lio_event is created in lio_create() which contains the necessary information
for signaling a thread (signal number, pid, notify type and value) along with
a count of requests attached to this event.

  The following depicts the lio_event structure:

        struct lio_event {
                atomic_t        lio_users;
                int             lio_wait;
                __s32           lio_pid;
                __u16           lio_signo;
                __u16           lio_notify;
                __u64           lio_value;
                uid_t           lio_uid, lio_euid;
        };

  lio_users holds a count of the number of requests attached to this lio. It
is incremented with each request submitted and decremented at each request
completion. Thread notification occurs when this count reaches 0.

  Each subsequent submitted request is attached to this lio_event by setting
the request kiocb->*ki_lio to that lio_event (in io_submit_one()) and
incrementing the lio_users count.

  In aio_complete(), if the request is attached to an lio (ki_lio <> 0), then
lio_check() is called to decrement the lio_users count and eventually signal
the user process when all the requests in the group have completed.


  The IOCB_CMD_GROUP command semantic is as follows:

       - if the associated aiocb sigevent is NULL then we want to group
         requests for the purpose of blocking on the group completion
         (LIO_WAIT sync behavior).

       - if the associated sigevent is valid (not NULL) then we want to
         group requests for the purpose of being notified upon that
         group of requests completion (LIO_NOWAIT async behaviour).

--=-5x10Zz0yOl41ppCZ1U7e--

