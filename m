Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbTEBPqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbTEBPqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:46:14 -0400
Received: from [64.122.104.98] ([64.122.104.98]:26116 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id S262957AbTEBPqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:46:05 -0400
Subject: strsep() question/modification
From: Nat Ersoz <nat.ersoz@myrio.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Myrio Corporation
Message-Id: <1051890980.20514.32.camel@ersoz.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 May 2003 08:56:20 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 15:58:25.0411 (UTC) FILETIME=[AA0C5D30:01C310C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please reply to me also, I'm not an LKML subscriber)

strsep() looks a bit busted to to me.  It fails to strip out preceeding
delimiters which may occur in front of the token(s) you're looking for.

I don't know if strsep() has been modified since 2.4.20 to fix this (or
perhaps someone will tell me this is the correct behaviour).  The
following code is a small userland test app to illustrate the problem.

Thanks for reading,

Nat

=== simple usage:
#define STRSEP strsep	/* pick one, to test functionality */
#define STRSEP strsep2

compile...  gcc -o test test.c

./test ",,,4,,,5,,,"	/* STRSEP == strsep */
[1]',,4,,5,,': '' '' '4' '' '5' '' ''
/* note zero lenght tokens returned */

./test ",,4,,5,,"	/* STRSEP == strsep2 */
[1]'  4  5  ': '4' '5'
/* no more false zero len tokens */

=== code follows (apologies as importance/msglen approaches 0)
#include <stdio.h>

/* move past chars if found in set ct */
static char* strpbrkn(const char * cs,const char * ct)
{
  const char *sc1,*sc2;

  for( sc1 = cs; *sc1 != '\0'; ++sc1 ) {
    for( sc2 = ct; *sc2 != '\0'; ++sc2 ) {
      if( *sc1 == *sc2 )
        break;
    }
    if( *sc2 == '\0' )  /* no chars in ct were found */
      return(char*)sc1;
  }
  return NULL;
}

/* unchanged from kernel source string.c */
static char* strpbrk(const char * cs,const char * ct)
{
  const char *sc1,*sc2;

  for( sc1 = cs; *sc1 != '\0'; ++sc1 ) {
    for( sc2 = ct; *sc2 != '\0'; ++sc2 ) {
      if( *sc1 == *sc2 )
        return(char *) sc1;
    }
  }
  return NULL;
}

/* new strsep function */
char* strsep2(char **s, const char *ct)
{
  char *beg = *s, *end;

  if( beg == NULL )
    return NULL;

  beg = strpbrkn( beg, ct );
  if( beg ) {
    end = strpbrk( beg, ct );
    if( end )
      *end++ = '\0';
    *s = end;
  } else
    *s = NULL;

  return beg;
}

/* same old strsep */
char * strsep(char **s, const char *ct)
{
  char *sbegin = *s, *end;

  if (sbegin == NULL)
    return NULL;

  end = strpbrk(sbegin, ct);
  if (end)
    *end++ = '\0';
  *s = end;

  return sbegin;
}

#define STRSEP  strsep

int main( int argc, char **argv )
{
  int i;

  const char *delim = " =\t\n\r,";

  for( i = 1; i < argc; i++ ) {
    char *tok, *ptr = argv[i];

    printf( "[%d]'%s': ", i, ptr );

    tok = STRSEP( &ptr, delim );
    while( tok ) {
      printf( "'%s' ", tok );
      tok = STRSEP( &ptr, delim );
    }
    printf( "\n" );
    fflush( stdout );
  }

  return 0;
}


