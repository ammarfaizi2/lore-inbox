Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131261AbRCHDBf>; Wed, 7 Mar 2001 22:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131262AbRCHDBW>; Wed, 7 Mar 2001 22:01:22 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:32014 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131261AbRCHDBB>; Wed, 7 Mar 2001 22:01:01 -0500
Message-ID: <3AA8475F.D2AD02D4@sgi.com>
Date: Thu, 08 Mar 2001 21:00:47 -0600
From: Sam Watters <watters@sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.2 - Linux Jobs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applies against the 2.4.2 kernel, supports i386 and ia64, and depends
upon the Linux Process Aggregates (PAGG) patch (linux-2.4.2-pagg.patch).
The PAGG patch was delivered in a previous post with the subject: "[PATCH]
2.4.2 - Process Aggregates".  At the bottom of this description will be
a web page reference that allows these patches and a command package to
be downloaded.

This patch implements a process aggregate container -- a generic
process group.  Specifically, this patch implements process groups
called jobs.  

A job is a group of related processes, all descended from a point of entry
(POE) process and identified by a unique job ID.  A job can contain
multiple process groups, session, and processes.  The job acts as a
process containment mechanism and a process is not allowed to escape
from the job container.  This allows resource limits to be extended
from the process level to the job level.  Additionally, the job allows
accounting information to be accumulated for all processes that executed
within the job container.  This provides users and administrators with
increased capabilities for system scheduling and planning for work loads.

The job, has the following characteristics:

-  A job is an inescapable container.  A process cannot leave the job 
   container nor can a new process be created outside the job without 
   explicit  action, that is, a system call with root privilege.

-  Each new process inherits the job ID and limits from its parent  
   process.

-  All point of entry processes (job initiators) create a new job and 
   set the job limits appropriately.

-  Users can raise and lower their own job limits within maximum 
   values specified by the system administrator.

-  The job initiator performs authentication and security checks.

-  The process control initialization process (init(1M)) and start-up  
   scripts called by init are not part of a job.  Likewise, system 
   daemons are usually not part of a job.  

This work was done so that we could provide a job accounting package
(called CSA).

For additional information about process aggregates & jobs, please go
to the home page at:

        http://oss.sgi.com/projects/pagg

At this site you can download these patches and the commands package
(in RPM or tarball format).  Also, there are additional patches for
other 2.4.x kernels.

For additional information about CSA job accounting, please consult the
home page at:

        http://oss.sgicom/projects/csa

patch follows (linux-2.4.2-pagg-job.patch):
---------------------------------------------------------------
diff -Naur linux-2.4.2-pagg/Documentation/Configure.help
linux-2.4.2-pagg-job/Documentation/Configure.help
--- linux-2.4.2-pagg/Documentation/Configure.help	Mon Mar  5 08:46:36 2001
+++ linux-2.4.2-pagg-job/Documentation/Configure.help	Mon Mar  5 08:58:43 2001
@@ -14656,6 +14656,34 @@
   include the Linux Jobs module and the Linux Array Sessions module.
   If you will not be using such modules, say N.
 
+Process Aggregates Job support
+CONFIG_PAGG_JOB
+  The Job feature implements a type of process aggregate,
+  or grouping.  A job is the collection of all processes that
+  are descended from a point-of-entry process.  Examples of such
+  points-of-entry include telnet, rlogin, and console logins.
+  A job differs from a session and process group since the job
+  container (or group) is inescapable.  Only root level processes,
+  or those with the CAP_SYS_RESOURCE capability, can create new jobs
+  or escape from a job.
+
+  A job is identified by a unique job identifier (jid).  Currently,
+  that jid can be used to obtain status information about the job
+  and the processes it contians.  The jid can also be used to send
+  signals to all processes contained in the job.  In addition,
+  other processes can wait for the completion of a job - the event
+  where the last process contained in the job has exited.
+
+  In the future, resource limit features will be added to jobs.
+  Such limits would be enforced against the aggregate usage of
+  resources by all processes within the job.
+
+  If you want to compile support for jobs into the kernel, select
+  this entry using Y.  If you want the support for jobs provided as
+  a module, select this entry using M.  If you do not want support
+  for jobs, select this entry using N (this is the default setting).
+
+
 ISDN subsystem
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
diff -Naur linux-2.4.2-pagg/Documentation/job.txt
linux-2.4.2-pagg-job/Documentation/job.txt
--- linux-2.4.2-pagg/Documentation/job.txt	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2-pagg-job/Documentation/job.txt	Mon Mar  5 08:58:43 2001
@@ -0,0 +1,610 @@
+Linux Jobs - A Process Aggregate (PAGG) Module
+----------------------------------------------
+
+Comments by:  	Sam Watters <watters@sgi.com>
+Last Change:	2001.01.30
+
+
+1. Overview
+
+This document provides two additional sections.  Section 2 provides a
+listing of the manual page that describes the particulars of the Linux
+job implementation.  Section 3 provides a listing of the manual page
+describing the Linux job support for the paggctl(3) system call.
+
+2. Job Man Page
+
+
+JOB(7)		       Linux User's Manual		   JOB(7)
+
+
+NAME
+       job - Linux Jobs kernel module overiew
+
+DESCRIPTION
+       A job is a group of related processes all descended from a
+       point of entry process and  identified  by  a  unique  job
+       identifier  (jid).   A  job  can	 contain multiple process
+       groups or sessions, and all processes in one of these sub-
+       groups can only be contained within a single job.
+
+       The  primary  purpose  for  having  jobs is to provide job
+       based resource limits.  The  current  implementation  only
+       provides	 the  job  container  and resource limits will be
+       provided in a later implementation.  When  an  implementa-
+       tion  that provides job limits is available, this descrip-
+       tion will be expanded to provide	 further  explanation  of
+       job based limits.
+
+       Not  every  process  on the system is part of a job.  That
+       is, only processes which are started by a login	initiator
+       like  login, rlogin, rsh and so on, get assigned a job ID.
+       In the Linux environment, jobs are created via a PAM  mod-
+       ule.
+
+       Jobs on Linux are provided using a loadable kernel module.
+       Linux jobs have the following characteristics:
+
+       o   A job is an inescapable container.  A  process  cannot
+	   leave the job nor can a new process be created outside
+	   the job without explicit action,  that  is,	a  system
+	   call with root privilege.
+
+       o   Each	 new  process  inherits	 the jid and limits [when
+	   implemented] from its parent process.
+
+       o   All point of entry processes (job initiators) create a
+	   new	job  and  set  the  job limits [when implemented]
+	   appropriately.
+
+       o   Job initiation on Linux is performed via a PAM session
+	   module.
+
+       o   The job initiator performs authentication and security
+	   checks.
+
+       o   Users can raise and lower their own job limits  within
+	   maximum  values  specified by the system administrator
+	   [when implemented].
+
+       o   Not all pocesses on a system need be members of a job.
+
+       o   The	process control initialization process (init(1M))
+	   and startup scripts called by init are not part  of	a
+	   job.
+
+
+
+Linux Utilities		 12 December 2000			1
+
+
+
+
+
+JOB(7)		       Linux User's Manual		   JOB(7)
+
+
+       Job initiators can be categorized as either interactive or
+       batch processes.	 Limit domain names are	 defined  by  the
+       system  administrator when the user limits database (ULDB)
+       is created.  [The ULDB will be implemented in  conjunction
+       with future job limits work.]
+
+       Note: The existing command jobs(1) applies to shell "jobs"
+       and it is not related to the  Linux  Kernel  Module  jobs.
+       The  at(1),  atd(8),  atq(1), batch(1), atrun(8), atrm(1))
+       man pages refer to  shell  scripts  as  a  job.	 a  shell
+       script.
+
+SEE ALSO
+       job(1), jwait(1), jstat(1), jkill(1)
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+Linux Utilities		 12 December 2000			2
+
+
+
+3. Man Page for Job paggctl(3) System Call Support
+
+
+job_paggctl(3)					   job_paggctl(3)
+
+
+NAME
+       job_paggctl,  paggctl  - control and obtain status for the
+       Job PAGG module
+
+SYNOPSIS
+       #include <job_paggctl.h>
+
+       int paggctl (char *module_name, int request, void *data);
+
+DESCRIPTION
+       The paggctl system call is used as the system call  inter-
+       face  for Process Aggregation (PAGG) modules.  The paggctl
+       system call allows processes to obtain status  information
+       about jobs and to create new jobs.  When the Job module is
+       to be used to service a request, the job_paggctl.h  header
+       file  should  be	 included  to  obtain  the proper request
+       macros and data structures.
+
+       The use of the paggctl system call requires three  parame-
+       ters.   The  first, module_name, is a string that provides
+       the name module that should service the	request.  In  the
+       case  of	 a request for the Job module, the JOB_NAME macro
+       is provided to use for this argument.
+
+       The second argument, request, is a code that indicates  to
+       the  Job	 module	 what operation the caller is requesting.
+       Macros that specify  the	 requests  are	provided  in  the
+       job_paggctl.h include file.
+
+       The  final  arugment,  data, is a void pointer that refer-
+       ences the structure used to pass data between the  calling
+       process	and  the  Job  module's paggctl service function.
+       The data structure types passed via the data  pointer  are
+       defined in the job_paggctl.h include file.
+
+       The  Job	 module	 handles the following request macros (as
+       defined in job_paggctl):
+
+       JOB_CREATE
+	      Create a new job.	 The calling process is	 attached
+	      to    the	  new	job.	This   request	 requires
+	      CAP_SYS_RESOURCE	capability.   (See  the	 capabil-
+	      ity(4)  and  capabilities(4)  man	 pages	for  more
+	      information on the capability  mechanism	for  con-
+	      trolling	process	 privileges.)  The data structure
+	      pointed to by data is defined as follows:
+
+		   typedef struct job_create_s {
+			uint64_t   r_jid;
+			uint64_t   jid;
+			uid_t	   user;
+			int	   options;
+		   } job_create_t;
+
+
+
+
+								1
+
+
+
+
+
+job_paggctl(3)					   job_paggctl(3)
+
+
+	      The r_jid member is the job ID (jid) value used for
+	      the  new	job.   If  the	operation to create a job
+	      failed, then r_jid will be set to 0.  The jid  mem-
+	      ber allows the caller to specify a jid value to use
+	      when creating the job.  If the caller want the  Job
+	      module  to  generate the job ID, then set jid to 0.
+	      The user member is used to supply the user ID (uid)
+	      value  for  the  user  that  will own the job.  The
+	      options member is for future use.
+
+       JOB_GETJID
+	      Get the job ID (jid) for the specified process pid.
+	      The data structure pointed to by data is defined as
+	      follows:
+
+		   typedef struct job_getjid_s {
+			uint64_t  r_jid;
+			pid_t	       pid;
+		   } job_getjid_t;
+
+	      The  r_jid  member is  the job ID  (jid)  value for
+	      the job to  which  process is  attached.  The r_jid
+	      value will be equal to  0 if the attempt to get the
+	      job ID failed,  and errno will be set to  indi-cate
+	      the  error.  The pid member is used  to specify the
+	      process for which the caller is requesting the jid.
+
+       JOB_WAITJID
+	      Wait for the job, specified by the supplied jid, to
+	      complete.	 The data structure pointed to by data is
+	      defined as follows:
+
+		   typedef struct job_waitjid_s {
+			uint64_t  r_jid;
+			uint64_t  jid;
+			int	  stat;
+			int	  options;
+		   } job_waitjid_t;
+
+	      The r_jid data member is the jid value for the  job
+	      that  was	 waited	 upon.	 If  the  wait	operation
+	      failed, then r_jid will be set equal to 0 and errno
+	      will  be	set to indicate the error. The jid member
+	      is the jid value that identifies the  job	 to  wait
+	      upon.   The stat member is the completion status of
+	      the job.	The completion status  is  determined  by
+	      the  exit	 status	 for  the last process in the job
+	      that exits. The status can be evaluated  using  the
+	      same  macros  as	described  in  the wait(2) manual
+	      page.  The options data member is for future use.
+
+       JOB_KILLJID
+	      Send a signal to all  processes  in  the	specified
+	      job.  The data argument should point to a structure
+	      of type job_killjid_t defined as follows:
+
+
+
+								2
+
+
+
+
+
+job_paggctl(3)					   job_paggctl(3)
+
+
+		   typedef struct job_killjid_s {
+			int	  r_val;
+			uint64_t  jid;
+			int	  sig;
+		   } job_killjid_t;
+
+	      The r_val member is the return value for the opera-
+	      tion.   On success, r_val=0 and on failure r_val<0.
+	      The jid member specifies the  job	 that  should  be
+	      sent  the	 signal.   the	sig member specifies what
+	      signal should be sent.
+
+       JOB_GETJIDCNT
+	      Get the number of jobs  currently	 running  on  the
+	      system.  The data argument should point to a struc-
+	      ture of type job_jidcnt_t defined as follows:
+
+		   typedef struct job_jidcnt_s {
+			int	  r_val;
+		   } job_jidcnt_t;
+
+	      The number of jobs on the system is returned in the
+	      r_val  member.   This value will be greater than or
+	      equal to 0.
+
+       JOB_GETJIDLST
+	      Get the list of job jids for job currently  running
+	      on  the system. The data argument should point to a
+	      structure of type job_jidlst_t defined as follows:
+
+		   typedef struct job_jidlst_s {
+			int	  r_val;
+			uint64_t  *jid;
+		   } job_jidlst_t;
+
+	      The list of job jid values is returned in the array
+	      pointed  to  by  the  jid	 member.   The	caller is
+	      responsible for allocating and freeing  the  memory
+	      for the array pointed to by jid.	The caller speci-
+	      fies the number of elements in the array using  the
+	      r_val  member.   Upon return, the r_val member will
+	      contain the number of  job  jid  values  that  were
+	      inserted	into  the  array by the Job module.   The
+	      number of jid values returned via the jid	 list  is
+	      limited  to the number of elements specified by the
+	      caller using r_val.
+
+       JOB_GETPIDCNT
+	      Get the number of processes (pids)  attached  to	a
+	      specified job.  The data argument should point to a
+	      structure of type job_pidcnt_t, defined as follows:
+
+		   typedef struct job_pidcnt_s {
+			int	  r_val;
+
+
+
+								3
+
+
+
+
+
+job_paggctl(3)					   job_paggctl(3)
+
+
+			uint64_t  jid;
+		   } job_pidcnt_t;
+
+	      The  r_val member indicates the number of processes
+	      attached to the job upon return.	The jid member is
+	      set  by the caller to specify the job that is to be
+	      queried for the number of attached processes.
+
+       JOB_GETPIDLST
+	      Get the list of process pids attached to	a  speci-
+	      fied  job.   The	data  argument	should point to a
+	      structure of type job_pidlst_t, defined as follows:
+
+		   typedef struct job_pidlst_s {
+			int	  r_val;
+			pid_t	       *pid;
+			uint64_t  jid; } job_pidlst_t;
+
+	      The  list	 of process pid values is returned in the
+	      array pointed to by the pid member.  The caller  is
+	      responsible  for	allocating and freeing the memory
+	      for the array pointed to by pid.	The caller speci-
+	      fies  the number of elements in the array using the
+	      r_val member.  Upon return, the r_val  member  will
+	      contain the number of pid values that were inserted
+	      into the array by the Job module.	  The  number  of
+	      pid  values returned via the pid list is limited to
+	      the number of  elements  specified  by  the  caller
+	      using r_val.
+
+       JOB_GETUSER
+	      Get  the	owner of a job.	 The data argument should
+	      point to a structure of type job_user_t, defined as
+	      follows:
+
+		   typedef struct job_user_s {
+			uint16_t  r_user;
+			uint64_t  jid;
+		   } job_user_t;
+
+	      The jid member is used by the caller to specify the
+	      job to query to determine	 the  owning  user.   The
+	      r_user  member is set by the Job module to the user
+	      ID (uid) that owns the job.
+
+       JOB_GETPRIMEPID
+	      Get the prime (oldest) process pid for a job.   The
+	      data  argument  should point to a structure of type
+	      job_primepid_t, defined as follows:
+
+		   typedef struct job_primepid_s {
+			pid_t	       r_pid;
+			uint64_t  jid;
+		   } job_primepid_t;
+
+
+
+								4
+
+
+
+
+
+job_paggctl(3)					   job_paggctl(3)
+
+
+	      The jid member is used by the caller to specify the
+	      job  to  query.  The process ID (pid) value will be
+	      returned in the r_pid data member.  If  the  opera-
+	      tion  failed, then r_pid will be set to 0 and errno
+	      will be set to indicate the error.
+
+
+EXAMPLES
+       The following example shows how to print a list of job IDs
+       for  the jobs currently running on the system: You need to
+       use the following include statements:
+
+	    #include <stdarg.h>
+	    #include <unistd.h>
+	    #include <linux/unistd.h>
+	    #include <job_paggctl.h>
+
+	    int
+	    main(void)
+	    {
+		    job_jidcnt_t jidcnt;
+		    job_jidlst_t jidlst;
+		    int i;
+
+		    /* Get current number of jobs on system */
+		    jidcnt.r_val = 0;
+
+		    if (paggctl(JOB_NAME, JOB_GETJIDCNT,
+				    (void *)&jidcnt)) {
+			    perror("paggctl: JOB_GETJIDCNT");
+			    exit(1);
+		    }
+
+		    /* No jobs found on system */
+		    if (jidcnt.r_val == 0) {
+			    printf("No JIDs on system\n");
+			    return 0;
+		    }
+
+		    /* Alloc memory to hold list of jobs */
+		    jidlst.r_val = jidcnt.r_val;
+		    jidlst.jid = (uint64_t *)malloc(
+				   sizeof(uint64_t)
+				   *jidlst.r_val);
+
+		    /* Get list of jobs */
+		    if (paggctl(JOB_NAME, JOB_GETJIDLST,
+				    (void *)&jidlst)) {
+			    perror("paggctl: JOB_GETJIDLST");
+			    exit(1);
+		    }
+
+		    /* No jobs on system */
+		    if (jidlst.r_val == 0) {
+
+
+
+								5
+
+
+
+
+
+job_paggctl(3)					   job_paggctl(3)
+
+
+			    printf("No JIDs on system\n");
+			    free(jidlst.jid);
+			    return 0;
+		    }
+
+		    /* Print list of jobs on system */
+		    printf("List of JIDs on system0);
+		    for (i = 0; i < jidlst.r_val; i++) {
+			    printf("\t%0#18Lx\n", jidlst.jid[i]);
+		    }
+
+		    /* Free memory alloc'd for list */
+		    free(jidlst.jid);
+
+		    return 0;
+
+	    }
+
+
+ERRORS
+       Under the following conditions, the paggctl function fails
+       and sets errno to:
+
+       [EBADR]	      An invalid request code was provided.
+
+       [EBUSY]	      Attempt to create a new  job  using  a  jid
+		      value that is already in use.
+
+       [EFAULT]	      The  data	 pointer  references  an  invalid
+		      address.
+
+       [EINPROGRESS]  The job is in process of	dying  and  being
+		      cleaned up.
+
+       [EINVAL]	      An invalid argument was specified.
+
+       [ENODATA]      The  process is not a member of any job.	A
+		      jid value could not be
+
+       [ENOMEM]	      A memory allocation failed.
+
+       [ENOSYS]	      The Job module could not be found.  Perhaps
+		      it is not loaded?
+
+       [EPERM]	      The process does not have appropriate capa-
+		      bility for the requested operation.   found
+		      for the process in question.
+
+       [ESRCH]	      The process could not be found.
+
+DIAGNOSTICS
+       Upon  successful completion, paggctl returns a value of 0.
+       Otherwise, a value of -1 is returned and errno is  set  to
+       indicate the error.
+
+
+
+								6
+
+
+
+
+
+job_paggctl(3)					   job_paggctl(3)
+
+
+SEE ALSO
+       paggctl(3), job(7).
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+								7
+
+
diff -Naur linux-2.4.2-pagg/arch/i386/config.in
linux-2.4.2-pagg-job/arch/i386/config.in
--- linux-2.4.2-pagg/arch/i386/config.in	Mon Mar  5 08:46:36 2001
+++ linux-2.4.2-pagg-job/arch/i386/config.in	Mon Mar  5 08:58:43 2001
@@ -219,6 +219,9 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 bool 'Support for process aggregates (PAGGs)' CONFIG_PAGG
+if [ "$CONFIG_PAGG" = "y" ] ; then
+   tristate '    Process aggregate based jobs' CONFIG_PAGG_JOB
+fi
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
 	"ELF		CONFIG_KCORE_ELF	\
diff -Naur linux-2.4.2-pagg/arch/ia64/config.in
linux-2.4.2-pagg-job/arch/ia64/config.in
--- linux-2.4.2-pagg/arch/ia64/config.in	Mon Mar  5 08:46:36 2001
+++ linux-2.4.2-pagg-job/arch/ia64/config.in	Mon Mar  5 08:58:43 2001
@@ -94,6 +94,9 @@
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
 bool 'Support for process aggregates (PAGGs)' CONFIG_PAGG
+if [ "$CONFIG_PAGG" = "y" ] ; then
+   tristate '    Process aggregate based jobs' CONFIG_PAGG_JOB
+fi
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
diff -Naur linux-2.4.2-pagg/drivers/misc/Makefile
linux-2.4.2-pagg-job/drivers/misc/Makefile
--- linux-2.4.2-pagg/drivers/misc/Makefile	Fri Dec 29 16:07:22 2000
+++ linux-2.4.2-pagg-job/drivers/misc/Makefile	Mon Mar  5 08:58:43 2001
@@ -11,6 +11,10 @@
 
 O_TARGET := misc.o
 
+export-objs	:= job.o
+
+obj-$(CONFIG_PAGG_JOB) += job.o
+
 include $(TOPDIR)/Rules.make
 
 fastdep:
diff -Naur linux-2.4.2-pagg/drivers/misc/job.c
linux-2.4.2-pagg-job/drivers/misc/job.c
--- linux-2.4.2-pagg/drivers/misc/job.c	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2-pagg-job/drivers/misc/job.c	Mon Mar  5 08:58:43 2001
@@ -0,0 +1,1853 @@
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ *
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ *
+ * Description:	This file, drivers/misc/job.c, implements a type
+ * 		of process grouping called jos.  For further information
+ * 		about jobs, consult the file Documentation/job.txt. Jobs
+ * 		are implemented as a type of PAGG (process aggregate).  
+ * 		For further information about PAGGs, consult the file
+ * 		Documentation/pagg.txt.
+ *
+ * Created:	2000.07.15	Sam Watters <watters@sgi.com>
+ *
+ * Changes:	2001.01.30	Sam Watters <watters@sgi.com>
+ * 		Change job module so that it can be compiled into
+ * 		The kernel & move file to drivers/misc/job.c
+ */
+
+/* 
+ * Confessions of a locking amateur...
+ * 
+ *
+ * I admit to being a locking amateur, so beware!
+ *
+ * There are currently two levels of locking in this module.  So, we
+ * have two classes of locks: 
+ *
+ *	(1) job table lock (always, job_table_lock)
+ *	(2) job entry lock (usually, job->lock)
+ *
+ * There is only one job_table_lock.  There is a job->lock for each job
+ * entry in the job_table.
+ *
+ * Purpose:
+ *
+ *	(1) The job_table_lock protects all entries in the table.
+ *	(2) The job->lock protects all attachments to the job.
+ *
+ * Truths we hold to be self-evident:
+ *
+ * Only the holder of a JOB_WLOCK for the job_table_lock may add or
+ * delete a job entry from the job_table. The job_table includes all job
+ * entries in the hash table and chains off the hash table locations.
+ *
+ * Only the holder of a JOB_WLOCK for a job->lock may attach or detach
+ * processes/tasks from the attached list for the job.
+ *
+ * If you hold a JOB_RLOCK of job_table_lock, you can assume that the
+ * job entries in the table will not change.  The link pointers for
+ * the chains of job entries will not change, the job ID (jid) value
+ * will not change, and data changes will be (mostly) atomic.
+ *
+ * If you hold a JOB_RLOCK of a job->lock, you can assume that the
+ * attachments to the job will not change.  The link pointers for the
+ * attachment list will not change and the attachments will not change.
+ *
+ * If you are going to grab nested locks, the nesting order is:
+ *
+ *	tasklist_lock
+ *	job_table_lock
+ *	job->lock
+ *
+ * However, it is not strictly necessary to grab the job_table_lock
+ * before locking job->lock.  For example, to detach a attach a new
+ * process to an existing job, you would not need to lock the
+ * job_table_lock.
+ *
+ * Also, the nesting order allows you to lock in this order:
+ *
+ *	tasklist_lock
+ *	job->lock
+ *
+ * without locking job_table_lock between the two.
+ *
+ */
+
+/* standard for kernel modules */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/init.h>
+#include <linux/list.h>
+
+#include <asm/uaccess.h>	/* for get_user & put_user */
+
+#include <linux/sched.h>	/* for current */
+#include <linux/tty.h>		/* for the tty declarations */
+#include <linux/malloc.h>
+#include <linux/types.h>
+
+#include <linux/proc_fs.h>
+
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+
+#include <linux/pagg.h>		/* to use pagg hooks */
+#include <linux/job.h>
+#include <linux/paggctl.h>
+
+#define HASH_SIZE	1024
+
+/* The states for a job */ 
+#define FETAL	1	/* being born, not ready for attachments yet */
+#define RUNNING 2	/* Running job */
+#define STOPPED 3  	/* Stopped job */
+#define ZOMBIE  4	/* Dead job */
+
+
+#ifdef 	__BIG_ENDIAN
+#define		iptr_hid(ll) 	((uint32_t *)&(ll))
+#define		iptr_sid(ll) 	(((uint32_t *)(&(ll) + 1)) - 1)
+#else	/* __LITTLE_ENDIAN */
+#define		iptr_hid(ll) 	(((uint32_t *)(&(ll) + 1)) - 1)
+#define		iptr_sid(ll) 	((uint32_t *)&(ll))
+#endif	/* __BIG_ENDIAN */
+
+#define		jid_hash(ll) 	(*(iptr_sid(ll)) % HASH_SIZE)
+
+#define SUCCESS	"success"
+#define FAILURE	"failure"
+
+/* Need to declare ahead the types for the job data structures */
+typedef struct job_attach_s 	job_attach_t;
+typedef struct job_waitinfo_s   job_waitinfo_t;
+typedef struct job_csainfo_s	job_csainfo_t;
+typedef struct job_entry_s	job_entry_t;
+typedef struct job_task_s	job_task_t;
+
+/* Job info entry for member tasks */
+struct job_attach_s {
+	struct task_struct *task;
+	job_entry_t	   *job;
+	struct list_head   entry; 
+};
+
+struct job_waitinfo_s {
+	int	       	status;
+};
+
+struct job_csainfo_s {
+	uint64_t    corehimem;
+	uint64_t    virthimem;
+	struct file *acctfile;
+}; 
+
+/* Job table entry type */
+struct job_entry_s {
+	uint64_t	    jid;
+	int	    	    refcnt;
+	int		    state;
+	rwlock_t	    lock;
+	uid_t		    user;
+	time_t		    start;
+	job_csainfo_t       csa;
+	wait_queue_head_t   zombie;
+	wait_queue_head_t   wait;
+	int		    waitcnt;
+	job_waitinfo_t	    waitinfo;	    
+	struct list_head    attached;
+	struct list_head    entry;
+};
+
+struct job_task_s {
+	job_attach_t	*attached;
+};
+
+/* Job container tables */
+static struct list_head  job_table[HASH_SIZE];
+static int	    	 job_table_refcnt = 0;
+static rwlock_t    	 job_table_lock = RW_LOCK_UNLOCKED;
+
+
+/* Accounting subscriber list */
+static job_acctmod_t 	*acct_list[JOB_ACCT_COUNT];
+static rwlock_t		acct_list_lock = RW_LOCK_UNLOCKED;
+
+
+/* Host ID for the localhost */
+static uint32_t   jid_hid = 0;
+
+static char 	   *hid = NULL;	    
+
+MODULE_PARM(hid, "s");
+
+/* Function prototypes */
+int job_sys_create(job_create_t *);
+int job_sys_getjid(job_getjid_t *);
+int job_sys_waitjid(job_waitjid_t *);
+int job_sys_killjid(job_killjid_t *);
+int job_sys_getjidcnt(job_jidcnt_t *);
+int job_sys_getjidlst(job_jidlst_t *);
+int job_sys_getpidcnt(job_pidcnt_t *);
+int job_sys_getpidlst(job_pidlst_t *);
+int job_sys_getuser(job_user_t *);
+int job_sys_getprimepid(job_primepid_t *);
+int job_sys_sethid(job_sethid_t *);
+int job_sys_detachjid(job_detachjid_t *);
+int job_sys_detachpid(job_detachpid_t *);
+int job_attach(struct task_struct *, void *,struct pagg_task_s *);
+int job_detach(struct task_struct *, struct pagg_task_s *);
+int job_paggctl(int, void *);
+job_entry_t *job_findjid(uint64_t jid);
+uint64_t job_getjid(struct task_struct *);
+
+
+/* Job container kernel pagg entry */
+static struct pagg_module_s paggmod = {
+	PAGG_JOB,
+	job_attach,
+	job_detach,
+	NULL,
+	job_paggctl,
+	&job_table,
+	THIS_MODULE,
+	NULL
+};
+
+#ifdef DEBUG
+
+#define DBG_PRINTINIT(s)	\
+	char *dbg_fname = s		
+
+#define DBG_PRINTENTRY()					\
+do {								\
+	printk(KERN_DEBUG "job: %s: entry\n", dbg_fname);	\
+} while(0)
+
+#define DBG_PRINTEXIT(c)				 		\
+do {							 		\
+	printk(KERN_DEBUG "job: %s: exit, code = %d\n", dbg_fname, c);	\
+} while(0)
+
+#define JOB_WLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG "job: wlock = %p\n", l);	\
+	write_lock(l);					\
+} while(0);
+
+#define JOB_WUNLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG "job: wunlock = %p\n", l);	\
+	write_unlock(l);				\
+} while(0);
+
+#define JOB_RLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG "job: rlock = %p\n", l);	\
+	read_lock(l);					\
+} while(0);
+
+#define JOB_RUNLOCK(l)					\
+do {							\
+	printk(KERN_DEBUG "job: runlock = %p\n", l);	\
+	read_unlock(l);					\
+} while(0);
+
+#else /* #ifdef DEBUG */
+
+#define DBG_PRINTINIT(s)	
+
+#define DBG_PRINTENTRY() 	\
+do {				\
+} while(0)
+
+#define DBG_PRINTEXIT(c)	\
+do {				\
+} while(0)
+
+#define JOB_WLOCK(l)	\
+do {			\
+	write_lock(l);	\
+} while(0);
+
+#define JOB_WUNLOCK(l)	\
+do {			\
+	write_unlock(l);\
+} while(0);
+
+#define JOB_RLOCK(l)	\
+do {			\
+	read_lock(l);	\
+} while(0);
+
+#define JOB_RUNLOCK(l)	\
+do {			\
+	read_unlock(l);\
+} while(0);
+
+#endif /* #ifdef DEBUG */
+
+
+
+/* 
+ * job_findjid
+ *
+ * Given a jid value, find the entry in the job_table and return a pointer
+ * to the entry or NULL if not found.
+ *
+ * You should normally JOB_RLOCK the job_table_lock before calling this 
+ * function. I thought about putting JOB_RLOCK in here, but found that I
+ * always seem to have one set before calling this function.
+ */
+job_entry_t *
+job_findjid(uint64_t jid)
+{
+	struct list_head *job_list = NULL;
+	struct list_head *job_entry = NULL;
+	job_entry_t 	 *job = NULL;
+
+	job_list  = &job_table[ jid_hash(jid) ];
+	list_for_each(job_entry, job_list) {
+		job = list_entry(job_entry, job_entry_t, entry);
+		if (job->jid == jid) {
+			break;
+		}
+	}
+
+	if (job_entry == job_list) {
+		return NULL;
+	} else {
+		return job;
+	}
+}
+
+	
+/*
+ * job_attach
+ *
+ * attach the task to the job specified in the reference data (refdata).
+ *
+ * the function returns 0 upon success, and -1 upon failure.
+ */
+int
+job_attach(struct task_struct *c_task, void *parent_data,
+		struct pagg_task_s *c_pagg)
+{
+	job_attach_t *p_attached = ((job_task_t *)parent_data)->attached; 
+	job_entry_t  *job        = p_attached->job;
+	job_task_t   *c_jtask    = NULL;
+	job_attach_t *c_attached = NULL;
+	int          errcode     = 0;
+	DBG_PRINTINIT("job_attach");
+
+	DBG_PRINTENTRY();
+
+	/* Allocate memory that we will need */
+	c_jtask = (job_task_t *)kmalloc(sizeof(job_task_t *), GFP_KERNEL);
+	if (!c_jtask) { 
+		/* error */
+		printk(KERN_ERR "Attach task(pid=%d) to job"
+				" failed on memory error in kernel\n", 
+				c_task->pid);
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	c_attached = (job_attach_t *)kmalloc(sizeof(job_attach_t *), 
+			GFP_KERNEL);
+	if (!c_attached) {
+		/* error */
+		printk(KERN_ERR "Attach task(pid=%d) to job"
+				" failed on memory error in kernel\n", 
+				c_task->pid);
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	JOB_WLOCK(&tasklist_lock);
+	JOB_WLOCK(&job->lock);
+
+	if (job->state == ZOMBIE) {
+		/* If the job is a zombie (dying), bail out of the attach */
+		printk(KERN_WARNING "Attach task(pid=%d) to job"
+				" failed - job is ZOMBIE\n", 
+				c_task->pid);
+		errcode = -EINPROGRESS;
+		goto error_return;
+	}
+
+
+	c_jtask->attached = c_attached;
+	c_attached->task  = c_task;
+	c_attached->job   = job;
+	list_add_tail(&c_attached->entry, &job->attached);
+	c_pagg->data      = (void *)c_jtask;
+	job->refcnt++;  
+
+	JOB_WUNLOCK(&job->lock);  
+	JOB_WUNLOCK(&tasklist_lock);
+
+	DBG_PRINTEXIT(0);
+	return 0;
+
+error_return:
+	DBG_PRINTEXIT(errcode);
+	if (c_jtask) kfree(c_jtask);
+	if (c_attached) kfree(c_attached);
+	return errcode;
+}
+
+
+/*
+ * job_detach 
+ *
+ * detach the task from the job specified by the provided pagg_task_s
+ * structure, curnt.
+ *
+ * the function returns 0 uopn success, and -1 uopn failure.
+ */
+int
+job_detach(struct task_struct *task, struct pagg_task_s *curnt)
+{
+	job_attach_t *attached   = ((job_task_t *)curnt->data)->attached;
+	job_entry_t  *job        = attached->job;
+	DBG_PRINTINIT("job_detach");
+
+	DBG_PRINTENTRY();
+
+	/*
+	 * Obtain the lock on the the job_table_lock and the job->lock for this
+	 * job.
+	 */
+	JOB_WLOCK(&tasklist_lock);
+	JOB_WLOCK(&job_table_lock);
+	JOB_WLOCK(&job->lock);  
+
+	list_del(&attached->entry);
+	attached->job->refcnt--;
+	kfree(curnt->data);
+	kfree(attached);
+
+	if (job->refcnt == 0) {
+		int waitcnt;
+
+		list_del(&job->entry);
+		--job_table_refcnt;
+
+		/* 
+		 * The job is removed from the job_table.
+		 * We can remove the job_table_lock now since
+		 * nobody can access the job via the table.
+		 */
+		JOB_WUNLOCK(&job_table_lock);
+
+		job->state = ZOMBIE;
+		job->waitinfo.status = task->exit_code;
+
+		waitcnt = job->waitcnt;
+
+		/* 
+		 * Release the job lock.  You cannot hold
+		 * this lock if you want the wakeup to work
+		 * properly.
+		 */
+		JOB_WUNLOCK(&job->lock);
+		JOB_WUNLOCK(&tasklist_lock);
+
+		if (waitcnt > 0) {
+			wake_up_interruptible(&job->wait);
+			wait_event(job->zombie, job->waitcnt == 0);
+		} 
+
+		/* 
+		 * Job is exiting, all processes waiting for job to exit
+		 * have been notified.  Now we call the accounting
+		 * subscribers.
+		 */
+
+		/* - CSA accounting */
+		if (acct_list[JOB_ACCT_CSA]) {
+			__MOD_INC_USE_COUNT(acct_list[JOB_ACCT_CSA]->module);
+			if (acct_list[JOB_ACCT_CSA]->do_jobend) {
+				int res;
+				job_csa_t csa;
+
+				csa.job_id = job->jid;
+				csa.job_uid = job->user;
+				csa.job_start = job->start;
+				csa.job_corehimem = job->csa.corehimem;
+				csa.job_virthimem = job->csa.virthimem;
+				csa.job_acctfile = job->csa.acctfile;
+
+				res = acct_list[JOB_ACCT_CSA]->do_jobend(
+						JOB_EVENT_END,
+						&csa);
+				if (res) {
+					printk(KERN_WARNING "job_detach: CSA -"
+							" do_jobend failed.\n");
+				}
+			}
+			__MOD_DEC_USE_COUNT(acct_list[JOB_ACCT_CSA]->module);
+		}
+
+
+		/* 
+		 * Every process attached or waiting on this job should be
+	         * detached and finished waiting, so now we can free the
+		 * memory for the job.
+		 */
+		kfree(job);
+		MOD_DEC_USE_COUNT; 
+
+	} else {
+		/* This is case where job->refcnt was greater than 1, so
+		 * we were not going to delete the job after the detach.
+		 * Therefore, only the job->lock is being held - the 
+		 * job_table_lock was released earlier.
+		 */
+		JOB_WUNLOCK(&job->lock);
+		JOB_WUNLOCK(&job_table_lock);
+		JOB_WUNLOCK(&tasklist_lock);
+	}
+
+	DBG_PRINTEXIT(0);
+
+	return 0;
+}
+
+/*
+ * job_paggctl
+ *
+ * Function to handle paggctl system call requests.
+ *
+ * Returns 0 on success and -(ERRNO VALUE) upon failure.
+ */
+int
+job_paggctl(int request, void *data)
+{
+	DBG_PRINTINIT("job_paggctl");
+
+	DBG_PRINTENTRY();
+
+	switch (request) {
+		case JOB_CREATE:
+			return job_sys_create((job_create_t *)data);
+			break;
+		case JOB_ATTACH:
+		case JOB_DETACH:
+			/* RESERVED */
+			return -EBADR;
+			break;
+		case JOB_GETJID:
+			return job_sys_getjid((job_getjid_t *)data);
+			break;
+		case JOB_WAITJID:
+			return job_sys_waitjid((job_waitjid_t *)data);
+			break;
+		case JOB_KILLJID:
+			return job_sys_killjid((job_killjid_t *)data);
+			break;
+		case JOB_GETJIDCNT:
+			return job_sys_getjidcnt((job_jidcnt_t *)data);
+			break;
+		case JOB_GETJIDLST:
+			return job_sys_getjidlst((job_jidlst_t *)data);
+			break;
+		case JOB_GETPIDCNT:
+			return job_sys_getpidcnt((job_pidcnt_t *)data);
+			break;
+		case JOB_GETPIDLST:
+			return job_sys_getpidlst((job_pidlst_t *)data);
+			break;
+		case JOB_GETUSER:
+			return job_sys_getuser((job_user_t *)data);
+			break;
+		case JOB_GETPRIMEPID:
+			return job_sys_getprimepid((job_primepid_t *)data);
+			break;
+		case JOB_SETHID:
+			return job_sys_sethid((job_sethid_t *)data);
+			break;
+		case JOB_DETACHJID:
+			return job_sys_detachjid((job_detachjid_t *)data);
+			break;
+		case JOB_DETACHPID:
+			return job_sys_detachpid((job_detachpid_t *)data);
+			break;
+		case JOB_SETJLIMIT:
+		case JOB_GETJLIMIT:
+		case JOB_GETJUSAGE:
+		case JOB_FREE:
+		default:
+			/* For future enhancment */
+			DBG_PRINTEXIT(-EBADR);
+			return -EBADR;
+			break;
+	}
+
+	DBG_PRINTEXIT(0);
+	return 0;
+}
+
+
+/* 
+ * job_sys_create
+ *
+ * This function is used to create a new job and attache the calling process
+ * to that new job.
+ *
+ * Returns 0 on success, and negative on failure (negative errno value).
+ */
+int
+job_sys_create(job_create_t *create_args)
+{
+	job_create_t		create;
+	job_entry_t		*job 	  = NULL;
+	job_attach_t		*attached = NULL;
+	job_task_t		*jtask    = NULL;
+	struct pagg_task_s	*pagg     = NULL;
+	struct pagg_task_s	*paggnew  = NULL;
+	int			errcode   = 0;
+	DBG_PRINTINIT("job_sys_create");
+
+	DBG_PRINTENTRY();
+
+#if 0	/* XXX - Use if capable is not present */
+	if (current->euid != 0)
+		return -EPERM;
+#else	
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto error_return;
+	}
+#endif
+	if (!create_args) {
+		errcode = -EINVAL;
+		goto error_return;
+	}
+
+	if (copy_from_user(&create, create_args, sizeof(create)))  {
+		errcode = -EFAULT;
+		goto error_return;
+	}
+		
+	/* Allocate all of the memory we might need, before we spinlock */
+
+	attached = (job_attach_t *)kmalloc(sizeof(job_attach_t), GFP_KERNEL);
+	if (!attached) {
+		/* error */
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	job = (job_entry_t *)kmalloc(sizeof(job_entry_t), GFP_KERNEL);
+	if (!job) {
+		/* error */
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	jtask = (job_task_t *)kmalloc(sizeof(job_task_t), GFP_KERNEL);
+	if (!jtask) {
+		/* error */
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	paggnew = (struct pagg_task_s *)kmalloc(sizeof(struct pagg_task_s), 
+			GFP_KERNEL);
+	if (!paggnew) {
+		errcode = -ENOMEM;
+		goto error_return;
+	}
+
+	/* 
+	 * If this process is currently attached to another job,
+	 * we need to detach from that job before attaching to another 
+	 */
+	/* Try to find an existing job pagg attachment in process */
+	pagg = find_pagg(current, paggmod.name);
+	if (pagg) {
+		/* 
+		 * If existing job pagg found, detach from old job
+		 * and attach to new job.
+		 */
+		pagg->do_detach(current, pagg);
+		pagg->data = (void *)jtask;
+	} else {
+		/*
+		 * No existing job pagg was found, so we have to 
+		 * use a new one and fill in the values.
+		 */
+		pagg = paggnew;
+		pagg->name = paggmod.name;
+		pagg->do_attach = paggmod.do_attach;
+		pagg->do_detach = paggmod.do_detach;
+		pagg->data = (void *)jtask;
+		list_add(&pagg->entry, &current->pagg_list);
+	}
+
+	/* 
+	 * Lock the tasklist and add the pointers to the task struct.
+	 * Lock the jobtable and add the pointers for the new job.
+	 * Since the job is new, we won't need to lock the job_entry_t.
+	 */
+	JOB_WLOCK(&tasklist_lock);  
+	JOB_WLOCK(&job_table_lock);  
+
+	/*
+	 * Determine if create should use specified JID or one that is
+	 * generated.
+	 */
+	if (create.jid != 0) {
+		/* We use the specified JID value */
+
+		if (job_findjid(create.jid)) { 
+			/* JID already in use, bail */
+			JOB_WUNLOCK(&job_table_lock);
+			JOB_WUNLOCK(&tasklist_lock);
+			errcode = -EBUSY;
+			goto error_return;
+		} else {
+			/* Using specifiec JID */
+			job->jid = create.jid;
+		}
+	} else {	
+
+		/* We generate a new JID value */
+		*(iptr_hid(job->jid)) = jid_hid;
+		*(iptr_sid(job->jid)) = current->pid;
+	}
+
+	/* Initialize job entry values & lists */
+	job->refcnt = 1;
+	job->user = create.user;
+	job->start = jiffies;
+	job->csa.corehimem = 0;
+	job->csa.virthimem = 0;
+	job->csa.acctfile  = NULL;
+	job->state = FETAL;
+	job->lock = RW_LOCK_UNLOCKED;
+	INIT_LIST_HEAD(&job->attached);
+	list_add_tail(&attached->entry, &job->attached);
+	init_waitqueue_head(&job->wait);
+	init_waitqueue_head(&job->zombie);
+	job->waitcnt = 0;
+	job->waitinfo.status = 0;
+
+	/* set link for task to entry in attached list */
+	jtask->attached = attached;
+
+	/* set link from entry in attached list to task and job entry */
+	attached->task = current;
+	attached->job = job;
+
+	/* Insert new job into front of chain list */
+	list_add_tail(&job->entry, &job_table[ jid_hash(job->jid) ]);;
+	++job_table_refcnt;
+	job->state = RUNNING;
+
+	JOB_WUNLOCK(&job_table_lock); 
+	JOB_WUNLOCK(&tasklist_lock);  
+
+	/* Issue callbacks into accounting subscribers */
+
+	/* - CSA subscriber */
+	if (acct_list[JOB_ACCT_CSA]) {
+		__MOD_INC_USE_COUNT(acct_list[JOB_ACCT_CSA]->module);
+		if (acct_list[JOB_ACCT_CSA]->do_jobstart) {
+			int res;
+			job_csa_t csa;
+
+			csa.job_id = job->jid;
+			csa.job_uid = job->user;
+			csa.job_start = job->start;
+			csa.job_corehimem = job->csa.corehimem;
+			csa.job_virthimem = job->csa.virthimem;
+			csa.job_acctfile = job->csa.acctfile;
+
+			res = acct_list[JOB_ACCT_CSA]->do_jobstart(
+					JOB_EVENT_START,
+					&csa);
+			if (res < 0) {
+				printk(KERN_WARNING "job_sys_create: CSA -"
+						" do_jobstart failed.\n");
+			}
+		}
+		__MOD_DEC_USE_COUNT(acct_list[JOB_ACCT_CSA]->module);
+	}
+
+
+	/* If we didn't use memory allocated for pagg, release it */
+	if (pagg != paggnew)
+		kfree(paggnew);
+
+	MOD_INC_USE_COUNT; 
+
+	create.r_jid = job->jid;
+	copy_to_user(create_args, &create, sizeof(create));
+
+	DBG_PRINTEXIT(0);
+	return 0;
+
+error_return:
+	DBG_PRINTEXIT(errcode);
+	if (attached) kfree(attached);
+	if (job) kfree(job);
+	if (jtask) kfree(jtask);
+	if (paggnew) kfree(paggnew);
+
+	create.r_jid = 0;
+	copy_to_user(create_args, &create, sizeof(create));
+
+	return errcode;
+}
+
+
+/*
+ * job_sys_getjid
+ *
+ * Function retrieves the job ID (jid) for the specified process (pid).
+ *
+ * returns 0 on success, negative errno value on exit.
+ */
+int
+job_sys_getjid(job_getjid_t *getjid_args) 
+{
+	job_getjid_t	   getjid;
+	int		   errcode = 0;
+	struct task_struct *task;
+	DBG_PRINTINIT("job_sys_getjid");
+
+	DBG_PRINTENTRY();
+
+	if (copy_from_user(&getjid, getjid_args, sizeof(getjid))) {
+		DBG_PRINTEXIT(-EFAULT);
+		return -EFAULT;
+	}
+
+	/* 
+	 * Set job_table_lock, so no jobs can be deleted while doing
+	 * this operation.
+	 */
+	JOB_RLOCK(&job_table_lock); 
+
+	if (getjid.pid == current->pid) {
+		task = current;
+	} else {
+		task = find_task_by_pid(getjid.pid);
+	}
+	if (task) {
+		getjid.r_jid = job_getjid(task);
+		if (getjid.r_jid == 0) {
+			errcode = -ENODATA;
+		}
+	} else {
+		getjid.r_jid = 0;
+		errcode = -ESRCH;
+	}
+
+	JOB_RUNLOCK(&job_table_lock);
+
+	DBG_PRINTEXIT(errcode);
+	copy_to_user(getjid_args, &getjid, sizeof(getjid));
+	return errcode;
+}
+
+
+/* 
+ * job_sys_waitjid
+ *
+ * This job allows a process to wait until a job exits & it returns the 
+ * status information for the last process to exit the job.
+ *
+ * On success returns 0, failure it returns the negative errno value.
+ */
+int
+job_sys_waitjid(job_waitjid_t *waitjid_args)
+{
+	job_waitjid_t 	waitjid;
+	job_entry_t	*job;
+	int		retcode = 0;
+	DBG_PRINTINIT("job_sys_waitjid");
+
+	DBG_PRINTENTRY();
+
+	copy_from_user(&waitjid, waitjid_args, sizeof(waitjid));
+
+	waitjid.r_jid = waitjid.stat = 0;
+
+	if (waitjid.options != 0) {
+		retcode = -EINVAL;
+		goto general_return;
+	}
+
+	/* Lock the job table so that the current jobs don't change */
+	JOB_RLOCK(&job_table_lock);
+
+	job = job_findjid(waitjid.jid);
+
+	if ((job = job_findjid(waitjid.jid)) == NULL ) {
+		JOB_RUNLOCK(&job_table_lock);
+		retcode = -EINVAL;
+		goto general_return;
+	} 
+
+	/* 
+	 * We got the job we need, we can release the job_table_lock
+	 */
+	JOB_WLOCK(&job->lock);
+	JOB_RUNLOCK(&job_table_lock);
+
+	++job->waitcnt; 
+
+	JOB_WUNLOCK(&job->lock);
+
+	/* We shouldn't hold any locks at this point! */
+	retcode = wait_event_interruptible(job->wait, 
+			job->refcnt == 0);
+
+	if (!retcode) {
+		/* 
+		 * This data is static at this point, we will 
+		 * not need a lock to read it.
+		 */
+		waitjid.stat = job->waitinfo.status;
+		waitjid.r_jid = job->jid;
+	}
+
+	JOB_WLOCK(&job->lock);
+	--job->waitcnt;
+	
+	if (job->waitcnt == 0)  {
+		JOB_WUNLOCK(&job->lock);
+
+		/* We shouldn't hold any locks at this point! */
+		wake_up(&job->zombie);
+	} else {
+		JOB_WUNLOCK(&job->lock);
+	}
+
+general_return:
+
+	DBG_PRINTEXIT(retcode);
+	copy_to_user(waitjid_args, &waitjid, sizeof(waitjid));
+	return retcode;
+}
+
+
+/*
+ * job_sys_killjid
+ *
+ * This functions allows a signal to be sent to all processes in a job.
+ *
+ * returns 0 on success, negative of errno on failure.
+ */
+int
+job_sys_killjid(job_killjid_t *killjid_args)
+{
+	job_killjid_t	 killjid;
+	job_entry_t	 *job;
+	struct list_head *attached_entry;
+	struct siginfo   info;
+	int retcode = 0;
+	DBG_PRINTINIT("job_sys_killjid");
+
+	DBG_PRINTENTRY();
+
+	copy_from_user(&killjid, killjid_args, sizeof(killjid));
+
+	killjid.r_val = -1;
+
+	if (killjid.sig <= 0) {
+		retcode = -EINVAL;
+		goto cleanup_0locks_return;
+	} 
+
+	JOB_RLOCK(&tasklist_lock);
+	JOB_RLOCK(&job_table_lock);
+	job = job_findjid(killjid.jid);
+	if (!job) {
+		/* Job not found, copy back data & bail with error */
+		retcode = -EINVAL;
+		goto cleanup_2locks_return;
+	}
+
+	JOB_RLOCK(&job->lock);
+
+	/* 
+         * Check capability to signal job.  The signaling user must be
+	 * the owner of the job or have CAP_SYS_RESOURCE capability.
+	 */
+#if 0		/* Use this if not capability is available */
+	if (current->uid != 0) { 
+#else
+	if (!capable(CAP_SYS_RESOURCE)) {
+#endif
+		if (current->uid != job->user) {
+			retcode = -EPERM;
+			goto cleanup_3locks_return;
+		}
+	}
+
+	info.si_signo = killjid.sig;
+	info.si_errno = 0;
+	info.si_code = SI_USER;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	list_for_each(attached_entry, &job->attached) {
+		int err;
+		job_attach_t *attached;
+
+		attached = list_entry(attached_entry, job_attach_t, entry);
+		err = send_sig_info(killjid.sig, &info, 
+				attached->task);
+		if (err != 0) {
+			/* 
+			 * XXX - the "prime" process, or initiating process
+			 * for the job may not be owned by the user.  So,
+			 * we would get an error in this case.  However, we
+			 * ignore the error for that specific process - it
+			 * should exit when all the child processes exit. It 
+			 * should ignore all signals from the user.
+			 *
+			 * XXX - we are breaking the "data abstraction" for
+			 * the kernel provided doubly linked lists.  Oops.
+			 */
+			if (attached->entry.prev != &job->attached) {
+				retcode = err;
+			}
+		}
+
+	}
+
+cleanup_3locks_return:
+	JOB_RUNLOCK(&job->lock);
+cleanup_2locks_return:
+	JOB_RUNLOCK(&job_table_lock);
+	JOB_RUNLOCK(&tasklist_lock);
+cleanup_0locks_return:
+	killjid.r_val = retcode;
+	
+	DBG_PRINTEXIT(retcode);
+	copy_to_user(killjid_args, &killjid, sizeof(killjid));
+	return retcode;
+}
+
+
+/*
+ * job_sys_getjidcnt
+ *
+ * Retun the number of jobs currently on the system.
+ *
+ * returns 0 on success & it always succeeds.
+ */ 
+int
+job_sys_getjidcnt(job_jidcnt_t *jidcnt_args)
+{
+	job_jidcnt_t 	jidcnt;
+	DBG_PRINTINIT("job_sys_getjidcnt");
+
+	DBG_PRINTENTRY();
+
+	/* read lock might be overdoing it in this case */
+	JOB_RLOCK(&job_table_lock);
+	jidcnt.r_val = job_table_refcnt;
+	JOB_RUNLOCK(&job_table_lock);
+
+	DBG_PRINTEXIT(0);
+
+	copy_to_user(jidcnt_args, &jidcnt, sizeof(jidcnt));
+
+	return 0;
+}
+		
+
+/*
+ * job_sys_getjidlst
+ *
+ * Get the list of all jids currently on the system (limited by the number of 
+ * jobs there are and the number you say you can accept.
+ */
+int
+job_sys_getjidlst(job_jidlst_t *jidlst_args)
+{
+	job_jidlst_t	 jidlst;
+	uint64_t	 *jid;
+	job_entry_t	 *job;
+	struct list_head *job_entry;
+	int		 i;
+	int 		 count;
+	DBG_PRINTINIT("job_sys_getjidlst");
+
+	DBG_PRINTENTRY();
+
+	copy_from_user(&jidlst, jidlst_args, sizeof(jidlst));
+
+	if (jidlst.r_val == 0)  {
+		DBG_PRINTEXIT(0);
+		return 0;
+	}
+
+	jid = (uint64_t *)kmalloc(sizeof(uint64_t *)*jidlst.r_val, GFP_KERNEL);
+	if (!jid) {
+		jidlst.r_val = 0;
+		DBG_PRINTEXIT(-ENOMEM);
+		copy_to_user(jidlst_args, &jidlst, sizeof(jidlst));
+		return -ENOMEM;
+	}
+
+
+	count = 0;
+	JOB_RLOCK(&job_table_lock);
+	for (i = 0; i < HASH_SIZE && count < jidlst.r_val; i++) {
+		list_for_each(job_entry, &job_table[i]) {
+			job = list_entry(job_entry, job_entry_t, entry);
+			jid[count++] = job->jid;
+			if (count == jidlst.r_val) {
+				break;
+			}
+		}
+	}
+	JOB_RUNLOCK(&job_table_lock);
+
+	DBG_PRINTEXIT(0);
+	jidlst.r_val = count;
+
+	for (i = 0; i < count; i++) 
+		copy_to_user(jidlst.jid+i, &jid[i], sizeof(uint64_t));
+
+	kfree(jid);
+
+	copy_to_user(jidlst_args, &jidlst, sizeof(jidlst));
+	return 0;
+}
+
+
+/*
+ * job_sys_getpidcnt
+ *
+ * Get the number of processes currently attached to a specific job.
+ *
+ * returns 0 on success, or negative errno value on failure.
+ */
+int
+job_sys_getpidcnt(job_pidcnt_t *pidcnt_args)
+{
+	job_pidcnt_t pidcnt;
+	job_entry_t  *job;
+	int	     retcode = 0;
+	DBG_PRINTINIT("job_sys_getpidcnt");
+
+	DBG_PRINTENTRY();
+
+	copy_from_user(&pidcnt, pidcnt_args, sizeof(pidcnt));
+	pidcnt.r_val = 0;
+
+	JOB_RLOCK(&job_table_lock);
+	job = job_findjid(pidcnt.jid);
+	if (!job) {
+		retcode = -EINVAL;
+	} else {
+		/* Read lock might be overdoing it for this case */
+		JOB_RLOCK(&job->lock);
+		pidcnt.r_val = job->refcnt;
+		JOB_RUNLOCK(&job->lock);
+	}
+	JOB_RUNLOCK(&job_table_lock);
+
+	DBG_PRINTEXIT(retcode);
+
+	copy_to_user(pidcnt_args, &pidcnt, sizeof(pidcnt));
+	return retcode;
+}
+
+/*
+ * job_getpidlst
+ *
+ * Get the list of processes (pids) currently attached to the specified
+ * job.  The number of processes provided is limited by the number the user
+ * specivies that they can accept (have memory for) and the number currently
+ * attached.
+ *
+ * returns 0 on success, negative errno value on failure.
+ */
+int
+job_sys_getpidlst(job_pidlst_t *pidlst_args)
+{
+	job_pidlst_t	 pidlst;
+	job_entry_t	 *job;
+	job_attach_t	 *attached;
+	struct list_head *attached_entry;
+	pid_t		 *pid;
+	int		 max;
+	int		 i;
+	DBG_PRINTINIT("job_sys_getpidlst");
+
+	DBG_PRINTENTRY();
+
+	copy_from_user(&pidlst, pidlst_args, sizeof(pidlst));
+
+	if (pidlst.r_val == 0) {
+		DBG_PRINTEXIT(0);
+		return 0;
+	}
+
+	max = pidlst.r_val;
+	pidlst.r_val = 0;
+	pid = (pid_t *)kmalloc(sizeof(pid_t)*max, GFP_KERNEL);
+	if (!pid) {
+		DBG_PRINTEXIT(-ENOMEM);
+		copy_to_user(pidlst_args, &pidlst, sizeof(pidlst));
+		return -ENOMEM;
+	}
+
+	JOB_RLOCK(&job_table_lock);
+
+	job = job_findjid(pidlst.jid);
+	if (!job) {
+
+		JOB_RUNLOCK(&job_table_lock);
+
+		DBG_PRINTEXIT(-EINVAL);
+		copy_to_user(pidlst_args, &pidlst, sizeof(pidlst));
+		return -EINVAL;
+	} else {
+
+		JOB_RLOCK(&job->lock);
+		JOB_RUNLOCK(&job_table_lock);
+
+		i = 0;
+		list_for_each(attached_entry, &job->attached) {
+			if (i == max) {
+				break;
+			}
+			attached = list_entry(attached_entry, job_attach_t, 
+					entry);
+			pid[i++] = attached->task->pid;
+		}
+		pidlst.r_val = i;
+
+		JOB_RUNLOCK(&job->lock);
+	}
+
+	for (i = 0; i < pidlst.r_val; i++) {
+		copy_to_user(pidlst.pid+i, &pid[i], sizeof(pid_t));
+	}
+	kfree(pid);
+
+	DBG_PRINTEXIT(0);
+	copy_to_user(pidlst_args, &pidlst, sizeof(pidlst));
+	return 0;
+}
+
+
+/*
+ * job_sys_getuser
+ *
+ * Get the uid of the user that owns the job.
+ *
+ * returns 0 on success, returns negative errno on failure.
+ */
+int
+job_sys_getuser(job_user_t *user_args)
+{
+	job_entry_t *job;
+	job_user_t user;
+	int        retcode = 0;
+	DBG_PRINTINIT("job_sys_getuser");
+
+	DBG_PRINTENTRY();
+
+	copy_from_user(&user, user_args, sizeof(user));
+	user.r_user = 0;
+
+	JOB_RLOCK(&job_table_lock);
+
+	job = job_findjid(user.jid);
+	if (!job) {
+		retcode = -EINVAL;
+	} else {
+		user.r_user = job->user;
+	}
+
+	JOB_RUNLOCK(&job_table_lock);
+
+	copy_to_user(user_args, &user, sizeof(user));
+	DBG_PRINTEXIT(retcode);
+	return retcode;
+}
+
+
+/* 
+ * job_sys_getprimepid
+ *
+ * Get the primary process - the oldest process in the job.
+ *
+ * returns 0 on success, negative errno on failure.
+ */
+int
+job_sys_getprimepid(job_primepid_t *primepid_args)
+{
+	job_primepid_t   primepid;
+	job_entry_t      *job;
+	job_attach_t     *attached;
+	struct list_head *attached_entry;
+	int              retcode = 0;
+	DBG_PRINTINIT("getprimepid");
+
+	DBG_PRINTENTRY();
+
+	copy_from_user(&primepid, primepid_args, sizeof(primepid));
+	primepid.r_pid = 0;
+
+	JOB_RLOCK(&job_table_lock);
+
+	job = job_findjid(primepid.jid);
+	if (!job) {
+		/* Job not found, return INVALID VALUE */
+		DBG_PRINTEXIT(-EINVAL);
+		retcode = -EINVAL;
+	} else {
+		/* 
+		 * Job found, now look at first pid entry in the 
+		 * attached list.
+		 */
+		JOB_RLOCK(&job->lock);
+		attached = NULL;
+		list_for_each(attached_entry, &job->attached) {
+			attached = list_entry(attached_entry, job_attach_t, 
+					entry);
+			break;
+		}
+
+		if (!attached) {
+			retcode = -EINVAL;
+		} else if (!attached->task) {
+			retcode = -EINVAL;
+		} else {
+			primepid.r_pid = attached->task->pid;
+		}
+		JOB_RUNLOCK(&job->lock);
+	}
+	JOB_RUNLOCK(&job_table_lock);
+
+	copy_to_user(primepid_args, &primepid, sizeof(primepid));
+	DBG_PRINTEXIT(retcode);
+	return retcode;
+	
+}
+
+
+/* 
+ * job_sys_sethid
+ *
+ * This function is used to set the host ID segment for the job IDs (jid).
+ * If this does not get set, then the jids upper 32 bits will be set to 
+ * 0 and the jid cannot be used reliably in a cluster environment.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+int
+job_sys_sethid(job_sethid_t *sethid_args)
+{
+	job_sethid_t	   sethid;
+	int		   errcode = 0;
+	DBG_PRINTINIT("job_sys_sethid");
+
+	DBG_PRINTENTRY();
+
+	if (copy_from_user(&sethid, sethid_args, sizeof(sethid))) {
+		DBG_PRINTEXIT(-EFAULT);
+		return -EFAULT;
+	}
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		sethid.r_hid = 0;
+		goto cleanup_return;
+	}
+
+	/* 
+	 * Set job_table_lock, so no jobs can be deleted while doing
+	 * this operation.
+	 */
+	JOB_WLOCK(&job_table_lock); 
+
+	sethid.r_hid = jid_hid = sethid.hid;
+
+	JOB_WUNLOCK(&job_table_lock);
+
+cleanup_return:
+	DBG_PRINTEXIT(errcode);
+	copy_to_user(sethid_args, &sethid, sizeof(sethid));
+	return errcode;
+}
+
+
+/* 
+ * job_sys_detachjid
+ *
+ * This function is detach all the processes from a job, but allows the 
+ * processes to continue running.  You need CAP_SYS_RESOURCE capability
+ * for this to succeed. Since all processes will be detached, the job will
+ * exit.
+ *
+ * returns -errno value on fail, 0 on success
+ */
+int
+job_sys_detachjid(job_detachjid_t *detachjid_args)
+{
+	job_detachjid_t	   detachjid;
+	job_entry_t	   *job;
+	struct list_head   *entry;
+	int		   count;
+	int		   errcode = 0;
+	DBG_PRINTINIT("job_sys_detachjid");
+
+	DBG_PRINTENTRY();
+
+	if (copy_from_user(&detachjid, detachjid_args, sizeof(detachjid))) {
+		DBG_PRINTEXIT(-EFAULT);
+		return -EFAULT;
+	}
+
+	detachjid.r_val = 0;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	/* 
+	 * Set job_table_lock, so no jobs can be deleted while doing
+	 * this operation.
+	 */
+	JOB_WLOCK(&job_table_lock); 
+
+	job = job_findjid(detachjid.jid);
+
+	if (job) {
+
+		JOB_WLOCK(&job->lock);
+
+		/* Mark job as ZOMBIE so no new processes can attach to it */	
+		job->state = ZOMBIE;
+
+		count = job->refcnt;
+
+		/* Okay, no new processes can attach to the job */
+		JOB_WUNLOCK(&job_table_lock);
+		JOB_WUNLOCK(&job->lock);
+
+		/* Walk through list of attached tasks and get paggs */
+		list_for_each(entry, &job->attached) {
+			struct pagg_task_s *pagg;
+			job_attach_t *attached = list_entry(entry, 
+					job_attach_t, entry);
+			pagg = find_pagg(attached->task, paggmod.name);
+			pagg->do_detach(attached->task, pagg);
+			list_del(&pagg->entry);
+			kfree(pagg);
+			++count;
+		}
+		detachjid.r_val = count;
+	} else {
+		errcode = -EINVAL;
+		JOB_WUNLOCK(&job_table_lock);
+	}
+
+cleanup_return:
+	DBG_PRINTEXIT(errcode);
+	copy_to_user(detachjid_args, &detachjid, sizeof(detachjid));
+	return errcode;
+}
+
+
+/* 
+ * job_sys_detachpid
+ *
+ * This function is detach a process from the job it is attached too, 
+ * but allows the processes to continue running.  You need 
+ * CAP_SYS_RESOURCE capability for this to succeed. 
+ *
+ * returns -errno value on fail, 0 on success
+ */
+int
+job_sys_detachpid(job_detachpid_t *detachpid_args)
+{
+	job_detachpid_t	   detachpid;
+	struct task_struct *task;
+	struct pagg_task_s *pagg;
+	int		   errcode = 0;
+	DBG_PRINTINIT("job_sys_detachpid");
+
+	DBG_PRINTENTRY();
+
+	if (copy_from_user(&detachpid, detachpid_args, sizeof(detachpid))) {
+		DBG_PRINTEXIT(-EFAULT);
+		return -EFAULT;
+	}
+
+	detachpid.r_jid = 0;
+
+	if (!capable(CAP_SYS_RESOURCE)) {
+		errcode = -EPERM;
+		goto cleanup_return;
+	}
+
+	task = find_task_by_pid(detachpid.pid);
+	if (!task) {
+		errcode = -EINVAL;
+		goto cleanup_return;
+	}
+
+	pagg = find_pagg(task, paggmod.name);
+	if (pagg) {
+		job_task_t *jtask = (job_task_t *)pagg->data;
+		
+		detachpid.r_jid = jtask->attached->job->jid;
+		pagg->do_detach(task, pagg);
+		list_del(&pagg->entry);
+		kfree(pagg);
+	} else {
+		errcode = -EINVAL;
+	}
+
+cleanup_return:
+	DBG_PRINTEXIT(errcode);
+	copy_to_user(detachpid_args, &detachpid, sizeof(detachpid));
+	return errcode;
+}
+
+
+/*
+ * job_register_acct
+ *
+ * This function is used by modules that are registering to provide job 
+ * accounting services.
+ *
+ * returns -errno value on fail, 0 on success.
+ */
+int 
+job_register_acct(job_acctmod_t *am)
+{
+	DBG_PRINTINIT("job_register_acct");
+
+	DBG_PRINTENTRY();
+
+	if (!am) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;	/* error, invalid value */
+	}
+	if (!am->module) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;	/* error, invalid value */
+	} 
+	if (am->type < 0 || am->type > (JOB_ACCT_COUNT-1)) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;	/* error, invalid value */
+	}
+
+	JOB_WLOCK(&acct_list_lock);
+	if (acct_list[am->type] != NULL) {
+		JOB_WUNLOCK(&acct_list_lock);
+		DBG_PRINTEXIT(-EBUSY);
+		return -EBUSY;	/* error, duplicate entry */
+	}
+
+	acct_list[am->type] = am;
+	JOB_WUNLOCK(&acct_list_lock);
+	DBG_PRINTEXIT(0);
+	return 0;
+}
+
+
+/*
+ * job_unregister_acct
+ *
+ * This is used by accounting modules to unregister with the job module as
+ * subscribers for job accounting information.
+ *
+ * Returns -errno on failure and 0 on success.
+ */
+int 
+job_unregister_acct(job_acctmod_t *am)
+{
+	DBG_PRINTINIT("job_unregister_acct");
+
+	DBG_PRINTENTRY();
+
+	if (!am) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;	/* error, invalid value */
+	}
+	if (!am->module) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;
+	}
+	if (am->type < 0 || am->type > (JOB_ACCT_COUNT-1))  {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;	/* error, invalid value */
+	}
+
+	JOB_WLOCK(&acct_list_lock);
+	if (acct_list[am->type] != am) {
+		JOB_WUNLOCK(&acct_list_lock);
+		DBG_PRINTEXIT(-EFAULT);
+		return -EFAULT;	/* error, not matching entry */
+	}
+
+	acct_list[am->type] = NULL;
+	JOB_WUNLOCK(&acct_list_lock);
+	DBG_PRINTEXIT(0);
+	return 0;
+}
+
+/*
+ * job_getjid
+ *
+ * This function will return the Job ID for the given task.  If
+ * the task is not attached to a job, then 0 is returned.
+ */
+uint64_t job_getjid(struct task_struct *task)
+{
+	struct pagg_task_s *pagg;
+	job_task_t	   *jtask = NULL;
+	uint64_t	   jid;
+	DBG_PRINTINIT("job_getjid");
+
+	DBG_PRINTENTRY();
+
+	JOB_RLOCK(&tasklist_lock);
+	JOB_RLOCK(&job_table_lock);
+	pagg = find_pagg(task, paggmod.name);
+	if (pagg) {
+		jtask = (job_task_t *)pagg->data;
+	}
+
+	if (jtask) {
+		jid = jtask->attached->job->jid;
+	} else {
+		jid = 0;
+	}
+	JOB_RUNLOCK(&job_table_lock);
+	JOB_RUNLOCK(&tasklist_lock);
+	DBG_PRINTEXIT((int)jid);
+	return jid;
+}
+
+/*
+ * job_getacct
+ *
+ * This function is used by accounting subscribers to get accounting 
+ * information about a job.
+ *
+ * The caller must supply the Job ID (jid) that specifies the job. The
+ * "type" argument indicates the type of accounting data to be returned.
+ * The data will be returned in the memory accessed via the data pointer
+ * argument.  The data pointer is void so that this function interface
+ * can handle different types of accounting data.
+ */
+int job_getacct(uint64_t jid, int type, void *data)
+{
+	job_entry_t	*job;
+	DBG_PRINTINIT("job_getacct");
+
+	DBG_PRINTENTRY();
+
+	if (!data) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;
+	}
+
+	if (!jid) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;
+	}
+
+	JOB_RLOCK(&job_table_lock);
+	job = job_findjid(jid);
+	if (!job) {
+		JOB_RUNLOCK(&job_table_lock);
+		DBG_PRINTEXIT(-ENOENT);
+		return -ENOENT;
+	}
+
+	JOB_RLOCK(&job->lock);
+	JOB_RUNLOCK(&job_table_lock);
+
+	switch (type) {
+		case JOB_ACCT_CSA: 
+		{
+			job_csa_t *csa = (job_csa_t *)data;
+
+			csa->job_id = job->jid;
+			csa->job_uid = job->user;
+			csa->job_start = job->start;
+			csa->job_corehimem = job->csa.corehimem;
+			csa->job_virthimem = job->csa.virthimem;
+			csa->job_acctfile = job->csa.acctfile;
+			break;
+		}
+		default:
+			JOB_RUNLOCK(&job->lock);
+			DBG_PRINTEXIT(-EINVAL);
+			return -EINVAL;
+			break;
+	}
+	JOB_RUNLOCK(&job->lock);
+	DBG_PRINTEXIT(0);
+	return 0;
+}
+
+/*
+ * job_setacct
+ *
+ * This function is used by accounting subscribers to set specific
+ * accounting information in the job (so that the job remembers it
+ * in relation to a specific job).
+ *
+ * The job is identified by the jid argument.  The type indicates the
+ * type of accounting the information is associated with.  The subfield
+ * is a bitmask that indicates exactly what subfields are to be changed.
+ * The data that is used to set the values is supplied by the data pointer.
+ * The data pointer is a void type so that the interface can be used for
+ * different types of accounting information.
+ */
+int job_setacct(uint64_t jid, int type, int subfield, void *data)
+{
+	job_entry_t	*job;
+	DBG_PRINTINIT("job_setacct");
+
+	DBG_PRINTENTRY();
+
+	if (!data) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;
+	}
+
+	if (!jid) {
+		DBG_PRINTEXIT(-EINVAL);
+		return -EINVAL;
+	}
+
+	JOB_RLOCK(&job_table_lock);
+	job = job_findjid(jid);
+	if (!job) {
+		JOB_RUNLOCK(&job_table_lock);
+		DBG_PRINTEXIT(-ENOENT);
+		return -ENOENT;
+	}
+
+	JOB_RLOCK(&job->lock);
+	JOB_RUNLOCK(&job_table_lock);
+
+	switch (type) {
+		case JOB_ACCT_CSA:
+		{
+			job_csa_t *csa = (job_csa_t *)data;
+			
+			if (subfield & JOB_CSA_ACCTFILE) {
+				job->csa.acctfile = csa->job_acctfile;
+			}
+			break;
+		}
+		default:
+			JOB_RUNLOCK(&job->lock);
+			DBG_PRINTEXIT(-EINVAL);
+			return -EINVAL;
+			break;
+	}
+	JOB_RUNLOCK(&job->lock);
+	DBG_PRINTEXIT(0);
+	return 0;
+}
+
+
+
+/* 
+ * init_module
+ *
+ * This function is called when a module is inserted into a kernel. This
+ * function allocates any necessary structures and sets initial values for
+ * module data.
+ *
+ * If the function succeeds, then 0 is returned.  On failure, -1 is returned.
+ */
+static int __init
+init_job(void) 
+{
+	int i;
+
+
+	/* Initialize the job table chains */
+	for (i = 0; i < HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&job_table[i]);
+	}
+
+	/* Initialize the list for accounting subscribers */
+	for (i = 0; i < JOB_ACCT_COUNT; i++) {
+		acct_list[i] = NULL;
+	}
+
+	/* Get hostID string and fill in jid_template hostID segment */
+	if (hid) {
+		jid_hid = (int)simple_strtoul(hid, &hid, 16);
+	} else {
+		jid_hid = 0;
+	}
+
+	return register_pagg(&paggmod);
+}
+
+/*
+ * cleanup_module
+ *
+ * This function is called to cleanup after a module when it is removed.
+ * All memory allocated for this module will be freed.
+ *
+ * This function does not take any inputs or produce and output.
+ */
+static void __exit
+cleanup_job(void)
+{
+	unregister_pagg(&paggmod);
+	return;
+}
+
+module_init(init_job);
+module_exit(cleanup_job);
+
+EXPORT_SYMBOL(job_register_acct);
+EXPORT_SYMBOL(job_unregister_acct);
+EXPORT_SYMBOL(job_getjid);
+EXPORT_SYMBOL(job_getacct);
+EXPORT_SYMBOL(job_setacct);
+
diff -Naur linux-2.4.2-pagg/include/linux/job.h
linux-2.4.2-pagg-job/include/linux/job.h
--- linux-2.4.2-pagg/include/linux/job.h	Wed Dec 31 18:00:00 1969
+++ linux-2.4.2-pagg-job/include/linux/job.h	Mon Mar  5 08:58:43 2001
@@ -0,0 +1,125 @@
+/*
+ * PAGG Job kernel definitions & interfaces
+ *
+ *
+ * Copyright (c) 2000 Silicon Graphics, Inc All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information:  Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
+ * Mountain View, CA  94043, or:
+ *
+ * http://www.sgi.com
+ *
+ * For further information regarding this notice, see:
+ * 
+ * http://oss.sgi.com/projects/GenInfo/NoticeExplan
+ *
+ * Description:  This file, include/linux/job.h, contains the data 
+ * 		 structure definitions and functions prototypes used
+ * 		 by other kernel bits that communicate with the job
+ * 		 module.  One such example is Comprehensive System 
+ * 		 Accounting  (CSA).
+ *
+ * Created:
+ *
+ * 	2000.07.15	Sam Watters <watters@sgi.com>
+ *
+ * Changes:
+ *
+ * 	2001.01.30	Sam Watters <watters@sgi.com>
+ * 	Moved file to include/linux/job.h 
+ *
+ */
+
+/* 
+ * ================
+ * GENERAL USE INFO
+ * ================
+ */
+
+/* 
+ * The job start/stop events: These will identify the 
+ * the reason the do_jobstart and do_jobend callbacks are being 
+ * called.
+ */
+#define JOB_EVENT_IGNORE	0
+#define JOB_EVENT_START		1
+#define JOB_EVENT_RESTART	2
+#define JOB_EVENT_END		3
+
+
+
+/* 
+ * =========================================
+ * INTERFACE INFO FOR ACCOUNTING SUBSCRIBERS 
+ * =========================================
+ */
+
+/* To register as a job dependent accounting module */
+typedef struct job_acctmod_s {
+	int     	type;   /* CSA or something else */
+	int     	(*do_jobstart)(int event, void *data);
+	int     	(*do_jobend)(int event, void *data);
+	struct module	*module;
+} job_acctmod_t;
+
+
+/* 
+ * Subscriber type: Each module that registers as a accounting data
+ * "subscriber" has to have a type.  This type will identify the 
+ * the appropriate structs and macros to use when exchanging data.
+ */
+#define JOB_ACCT_CSA	0
+#define JOB_ACCT_COUNT	1 /* Number of entries available */	
+
+/*
+ * --------------
+ * CSA ACCOUNTING 
+ * --------------
+ */
+
+
+/* 
+ * For data exchange betwee job and csa.  The embedded defines
+ * identify the sub-fields
+ */
+typedef struct job_csa_s {
+#define                 JOB_CSA_JID             001
+	uint64_t        job_id;
+#define                 JOB_CSA_UID             002
+	uid_t           job_uid;
+#define                 JOB_CSA_START           004
+	time_t          job_start;
+#define                 JOB_CSA_COREHIMEM       010
+	uint64_t        job_corehimem;
+#define                 JOB_CSA_VIRTHIMEM       020
+	uint64_t        job_virthimem;
+#define                 JOB_CSA_ACCTFILE        040
+	struct file     *job_acctfile;
+} job_csa_t;
+
+
+
+/* 
+ * ===================
+ * FUNCTION PROTOTYPES
+ * ===================
+ */
+int job_register_acct(job_acctmod_t *);
+int job_unregister_acct(job_acctmod_t *);
+uint64_t job_getjid(struct task_struct *);
+int job_getacct(uint64_t, int, void *);
+int job_setacct(uint64_t, int, int, void *);
diff -Naur linux-2.4.2-pagg/include/linux/paggctl.h
linux-2.4.2-pagg-job/include/linux/paggctl.h
--- linux-2.4.2-pagg/include/linux/paggctl.h	Mon Mar  5 08:46:37 2001
+++ linux-2.4.2-pagg-job/include/linux/paggctl.h	Mon Mar  5 08:58:43 2001
@@ -42,6 +42,133 @@
 #include <sys/types.h>
 #endif
 
+/*
+ * ====================
+ * JOB PAGG definitions
+ * ====================
+ */
+
+/* 
+ * Module identifier string 
+ */
+#define PAGG_JOB "job"
+
+/*
+ * 
+ * Define paggctl options available in the job module 
+ *
+ */
+
+#define JOB_N0OP	0	/* No-op options */
+
+#define JOB_CREATE	1	/* Create a job - uid = 0 only */
+#define JOB_ATTACH	2	/* RESERVED */
+#define JOB_DETACH	3	/* RESERVER */
+#define JOB_GETJID	4	/* Get Job ID for specificed pid */
+#define JOB_WAITJID	5	/* Wait for job to complete */	
+#define JOB_KILLJID	6	/* Send signal to job */
+#define JOB_GETJIDCNT	9	/* Get number of JIDs on system */
+#define JOB_GETJIDLST	10	/* Get list of JIDs on system */
+#define JOB_GETPIDCNT   11	/* Get number of PIDs in JID */
+#define JOB_GETPIDLST	12	/* Get list of PIDs in JID */
+#define JOB_SETJLIMIT	13	/* Future: set job limits info */
+#define JOB_GETJLIMIT	14	/* Future: get job limits info */
+#define JOB_GETJUSAGE	15	/* Future: get job res. usage */
+#define JOB_FREE	16	/* Future: Free job entry */
+#define JOB_GETUSER	17	/* Get owner for job */
+#define JOB_GETPRIMEPID	18	/* Get prime pid for job */
+#define JOB_SETHID	19	/* Set HID for jid values */
+#define JOB_DETACHJID	20	/* Detach all tasks from job */
+#define JOB_DETACHPID	21	/* Detach a task from job */
+
+#define PAGG_JOB_NOPTIONS	JOB_GETFIRSTPID+1		
+
+
+/*
+ * 
+ * Define paggctl request structures for job module 
+ *
+ */
+
+typedef struct job_create_s {
+	uint64_t 	r_jid;	/* Return value of JID */
+	uint64_t 	jid;	/* Jid value requested */
+	uid_t	 	user;	/* UID of user associated with job */
+	int	 	options;/* creation options - unused */
+} job_create_t;
+
+
+typedef struct job_getjid_s {
+	uint64_t 	r_jid;	/* Returned value of JID */
+	pid_t	 	pid;	/* Info requested for PID */
+} job_getjid_t;
+
+
+typedef struct job_waitjid_s {
+	uint64_t 	r_jid;	/* Returned value of JID */
+	uint64_t 	jid;	/* Waiting on specified JID */
+	int	 	stat;	/* Status information on JID */
+	int	 	options;/* Waiting options */ 
+} job_waitjid_t;
+
+
+typedef struct job_killjid_s {
+	int		r_val;	/* Return value of kill request */
+	uint64_t	jid;	/* Sending signal to all PIDs in JID */
+	int		sig;	/* Signal to send */
+} job_killjid_t;
+
+
+typedef struct job_jidcnt_s {
+	int		r_val;	/* Number of JIDs on system */
+} job_jidcnt_t;
+
+
+typedef struct job_jidlst_s {
+	int		r_val;	/* Number of JIDs in list */
+	uint64_t	*jid;	/* List of JIDs */
+} job_jidlst_t;
+
+
+typedef struct job_pidcnt_s {
+	int		r_val;	/* Number of PIDs in JID */
+	uint64_t	jid;	/* Getting count of JID */
+} job_pidcnt_t;
+
+
+typedef struct job_pidlst_s {
+	int		r_val;	/* Number of PIDs in list */
+	pid_t		*pid;	/* List of PIDs */
+	uint64_t	jid;
+} job_pidlst_t;
+
+
+typedef struct job_user_s {
+	uint16_t	r_user; /* The UID of the owning user */
+	uint64_t	jid;    /* Get the UID for this job */
+} job_user_t;
+
+typedef struct job_primepid_s {
+	pid_t		r_pid; /* The prime pid */
+	uint64_t	jid;   /* Get the prime pid for this job */
+} job_primepid_t;
+
+typedef struct job_sethid_s {
+	unsigned long	r_hid; /* Value that was set */
+	unsigned long	hid;   /* Value to set to */
+} job_sethid_t;
+
+
+typedef struct job_detachjid_s {
+	int		r_val; /* Number of tasks detached from job */
+	uint64_t	jid;   /* Job to detach processes from */
+} job_detachjid_t;
+
+typedef struct job_detachpid_s {
+	uint64_t	r_jid; /* Jod ID task was attached to */
+	pid_t		pid;   /* Task to detach from job */
+} job_detachpid_t;
+
 
 /*
  * =====================================================
