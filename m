Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTJTNGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTJTNGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:06:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:50068 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262566AbTJTNGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:06:36 -0400
Subject: K 2.6 test6 strange signal behaviour
From: Ken Foskey <foskey@optushome.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-tTmQbcPgI7el2lMZ+Thn"
Message-Id: <1066654886.5930.57.camel@gandalf.foskey.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 23:01:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tTmQbcPgI7el2lMZ+Thn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I have a problem with signals.

I get multiple signals from a single execution of the program.  I have
attached a stripped source.  Here is the critical snippet, you can see
the signal handler being set before each call:

	signal( SIGSEGV,	SignalHdl );
	signal( SIGBUS,		SignalHdl );
	fprintf( stderr, "Running \n" );
	result = func( eT, p );
	fprintf( stderr, "Finished \n" );
	signal( SIGSEGV,	SIG_DFL );
	signal( SIGBUS,		SIG_DFL );

When I run the code, that does 2 derefs of NULL you will see 2 instances
of "Running" and the handler is not invoked at all for the second time.

./solar:


Getting from NULL
Setting Jump
Running
Signal 11 caught
After jump
Setting to NULL
Setting Jump
Running
Segmentation fault

I am running debian version of K 2.6 test6.  This has occurred on all
versions of K2.6 though, not specific.

-- 
Thanks
KenF
OpenOffice.org developer

--=-tTmQbcPgI7el2lMZ+Thn
Content-Disposition: attachment; filename=solar.c
Content-Type: text/x-c; name=solar.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <signal.h>
#include <setjmp.h>

/*************************************************************************
|*	Typdeclarations for memory access test functions
*************************************************************************/
typedef int (*TestFunc)( void* );

/*************************************************************************
*************************************************************************/
static jmp_buf check_env;
static int bSignal;
static void SignalHdl( int sig )
{
  bSignal = 1;
  
  fprintf( stderr, "Signal %d caught\n", sig );
  longjmp( check_env, sig );
}

/*************************************************************************
*************************************************************************/
void check( TestFunc func, void* p )
{
  int result;

  fprintf( stderr, "Setting Jump\n" );
  if ( !setjmp( check_env ) )
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

--=-tTmQbcPgI7el2lMZ+Thn--

