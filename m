Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTJUB4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTJUB4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:56:19 -0400
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:33420 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262802AbTJUB4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:56:15 -0400
Subject: Re: K 2.6 test6 strange signal behaviour
From: Ken Foskey <foskey@optushome.com.au>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031020132805.5e5a59f1.akpm@osdl.org>
References: <1066654886.5930.57.camel@gandalf.foskey.org>
	 <20031020132805.5e5a59f1.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1066701370.1079.13.camel@gandalf.foskey.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 11:56:10 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 06:28, Andrew Morton wrote:
> Ken Foskey <foskey@optushome.com.au> wrote:
> >
> > I have a problem with signals.
> 
> You should be using sigsetjmp(), not setjmp().

No difference.  Note that this is K 2.6 specific, it "works" in K 2.4.

I am reading on sigaction now, I will recode with SA_RESTART tonight.  
I think this is not the solution because I am explicitly setting the
signal handler before every call.  I think this simply leaves the signal
handler active ie old BSD style.

I also received this comment:

> Unblock the signal handler before you raise the signal again.

I think this means sigprocmask with UNBLOCK.  "Should" this be
required.  After reading and Andrews comments I added a reset and
siglongjmp here is my current handler:

static void SignalHdl( int sig )
{
  bSignal = 1;
  
  fprintf( stderr, "Signal %d caught\n", sig );
  signal( sig, SIG_DFL );  /* reset handler back */
  siglongjmp( check_env, sig );  /* return to code */
}

I do have a work around, I am pursuing this because the signal handler
is behaving differently in K 2.6 than K 2.4.  The error may be mine
however it may also be a bug with the kernel.

-- 
Thanks
KenF
OpenOffice.org developer

Current code:

#include <stdio.h>
#include <signal.h>
#include <setjmp.h>

/*************************************************************************
|*	Typdeclarations for memory access test functions
*************************************************************************/
typedef int (*TestFunc)( void* );

/*************************************************************************
*************************************************************************/
static sigjmp_buf check_env;
static int bSignal;
static void SignalHdl( int sig )
{
  bSignal = 1;
  
  fprintf( stderr, "Signal %d caught\n", sig );
  signal( sig, SIG_DFL );
  siglongjmp( check_env, sig );
}

/*************************************************************************
*************************************************************************/
void check( TestFunc func, void* p )
{
  int result;

  fprintf( stderr, "Setting Jump\n" );
  if ( !sigsetjmp( check_env, 0 ) )
  {
	signal( SIGSEGV,	SignalHdl );
	signal( SIGBUS,		SignalHdl );
    fprintf( stderr, "Running \n" );
	result = func( p );
    fprintf( stderr, "Finished \n" );
	signal( SIGSEGV,	SIG_DFL );
	signal( SIGBUS,		SIG_DFL );
  }
  fprintf( stderr, "After jump \n" );
}

/*************************************************************************
*************************************************************************/
static int GetAtAddress( void* p )
{
  return *((char*)p);
}

/*************************************************************************
*************************************************************************/
static int SetAtAddress( void* p )
{
  return *((char*)p)	= 0;
}

/*************************************************************************
*************************************************************************/
void CheckGetAccess( void* p )
{
  check( (TestFunc)GetAtAddress, p );
}
/*************************************************************************
*************************************************************************/
void CheckSetAccess( void* p )
{
  check( (TestFunc)SetAtAddress, p );
}

/*************************************************************************
*************************************************************************/
int main( int argc, char* argv[] )
{
  {
	char* p = NULL;
	fprintf( stderr, "Getting from NULL\n" );
    CheckGetAccess( p );
	fprintf( stderr, "Setting to NULL\n" );
    CheckSetAccess( p );
	fprintf( stderr, "After Setting to NULL\n" );
  }

  exit( 0 );
}


