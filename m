Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311435AbSCMX0C>; Wed, 13 Mar 2002 18:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311436AbSCMXZx>; Wed, 13 Mar 2002 18:25:53 -0500
Received: from 64-60-75-69-cust.telepacific.net ([64.60.75.69]:13578 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S311435AbSCMXZl>; Wed, 13 Mar 2002 18:25:41 -0500
Message-ID: <3C8FDE12.D4A5B50B@ixiacom.com>
Date: Wed, 13 Mar 2002 15:17:38 -0800
From: Dan Kegel <dkegel@ixiacom.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@vger.kernel.org,
        sam@zoy.org, Xavier.Leroy@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem 
 (one li\ne)>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugs.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&database=default&pr=1427

IMHO gprof not working on Linux is getting to be
annoying for embedded developers adopting Linux.
The workaround is to have each new thread call setitimer.  
Users can do this in their programs (see
http://sam.zoy.org/doc/programming/gprof.html )
but it's not well known for some reason.  Perhaps everyone
figures if the workaround was so easy, it would have been fixed
in glibc long ago.

So let's break the logjam and fix glibc's linuxthreads' pthread_create to do
this.
Here's an untested patch that changes pthread_create
to sense (using sigaction) whether profiling is
active, and if so, arranges for the new thread to 
transparantly call setitimer before calling the user's
thread main.

Comments welcome...
- Dan

--- glibc-2.2.4/linuxthreads/pthread.c.orig     Wed Mar 13 12:01:42 2002
+++ glibc-2.2.4/linuxthreads/pthread.c  Wed Mar 13 12:31:23 2002
@@ -637,15 +637,73 @@
 
 /* Thread creation */
 
+/* profiling support: struct used to tell child thread how to call setitimer
*/
+typedef struct pthread_create_wrapper_s {
+  void *(*start_routine) (void *);
+  void *arg;
+
+  pthread_mutex_t lock;
+  pthread_cond_t wait;
+
+  struct itimerval itimer;
+} pthread_create_wrapper_t;
+
+/* profiling support: wrapper around child thread start routine to call
setitimer */
+static void *pthread_create_start_wrapper(void *data)
+{
+  /* Put user data in thread-local variables */
+  void *(*start_routine) (void *) = ((pthread_create_wrapper_t *)
data)->start_routine;
+  void *arg = ((pthread_create_wrapper_t *) data)->arg;
+
+  /* Turn on a profiling timer for this new thread. */
+  setitimer(ITIMER_PROF, &((pthread_create_wrapper_t *) data)->itimer, NULL);
+
+  /* Tell the calling thread that we don't need its data anymore */
+  __pthread_mutex_lock(&((pthread_create_wrapper_t *) data)->lock);
+  __pthread_cond_signal(&((pthread_create_wrapper_t *) data)->wait);
+  __pthread_mutex_unlock(&((pthread_create_wrapper_t *) data)->lock);
+
+  /* Call the real function */
+  return start_routine(arg);
+}
+
 int __pthread_create_2_1(pthread_t *thread, const pthread_attr_t *attr,
                         void * (*start_routine)(void *), void *arg)
 {
+  pthread_create_wrapper_t wrapper_data;
+  struct sigaction oact;
+  int profiling;
+
   pthread_descr self = thread_self();
   struct pthread_request request;
   int retval;
   if (__builtin_expect (__pthread_manager_request, 0) < 0) {
     if (__pthread_initialize_manager() < 0) return EAGAIN;
   }
+
+  /* profiling support:
+   * See if profiling is on.
+   * We know glibc uses sigaction for profiling,
+   * so it's safe to check sa_sigaction.
+   */
+  profiling = 0;
+  if (0 == sigaction(SIGPROF, 0, &oact)
+  &&  (oact.sa_sigaction != SIG_IGN)
+  &&  (oact.sa_sigaction != SIG_DFL)) {
+    profiling = 1;
+
+    /* Arrange for child thread to call setitimer so his cpu time will
+     * be profiled
+     */
+    wrapper_data.start_routine = start_routine;
+    start_routine = pthread_create_start_wrapper;
+    wrapper_data.arg = arg;
+    getitimer(ITIMER_PROF, &wrapper_data.itimer);
+    __pthread_cond_init(&wrapper_data.wait, NULL);
+    __pthread_mutex_init(&wrapper_data.lock, NULL);
+    __pthread_mutex_lock(&wrapper_data.lock);
+  }
+
   request.req_thread = self;
   request.req_kind = REQ_CREATE;
   request.req_args.create.attr = attr;
@@ -658,6 +716,18 @@
   retval = THREAD_GETMEM(self, p_retcode);
   if (__builtin_expect (retval, 0) == 0)
     *thread = (pthread_t) THREAD_GETMEM(self, p_retval);
+
+  /* profiling support:
+   * Wait for child thread to call setitimer, then free resources
+   */
+  if (profiling) {
+    if (retval == 0)
+      __pthread_cond_wait(&wrapper_data.wait, &wrapper_data.lock);
+    __pthread_mutex_unlock(&wrapper_data.lock);
+    __pthread_mutex_destroy(&wrapper_data.lock);
+    __pthread_cond_destroy(&wrapper_data.wait);
+  }
+
   return retval;
 }
