Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310372AbSCUMQz>; Thu, 21 Mar 2002 07:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310426AbSCUMQp>; Thu, 21 Mar 2002 07:16:45 -0500
Received: from violet.setuza.cz ([194.149.118.97]:52746 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S310372AbSCUMQe>;
	Thu, 21 Mar 2002 07:16:34 -0500
Subject: Documentation or software - bug?
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-dlv5jHEj9+lkBRIG5jzZ"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Mar 2002 13:16:33 +0100
Message-Id: <1016712993.1897.6.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dlv5jHEj9+lkBRIG5jzZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi there,

I try to set up a box without procfs, thus I've to set some kernel
parameters using _sysctl().

I wrote a little quick-n-dirty program to set at least integer and
struct ( or better array ) parameters.

I can set all struct, integer and boolean values with this program
except ip_forward.

Due to the docs ip_forward is a BOOLEAN parameter, so the length of the
value array for _sysctl should be 1.

... but ...

in ${KERNELSRC}/net/ipv4/sysctl_net_ipv4.c I find:
snip -->
<-- snap
static int ipv4_sysctl_forward_strategy(ctl_table *table ...
snip -->
<-- snap
	if (newlen != sizeof(int))
		return -EINVAL;
snip -->

If the config file for my program looks like this:
	# CTL_NET IPV4  FORWARD : YES
	3	  5     8	: 1
I get ``Invalid argument'' from my program.
If the config file for my program looks like this:
	3	  5     8	: 1 1 1 1
it works and I have a ``1'' in /proc/sys/net/ipv4/ip_forward.
... sure sizeof(int) is 4 on my machine.

My question:
Is there something wrong with the documentation, and NET_IPV4_FORWARD
awaits 4 integers to set/unset IP forwarding, or is something wrong in
sysctl_net_ipv4.c, or did I understand something wrong, and my program
has to be written in some other kind?

My program itself is in the attachment.

Thanks for every help
Frank

PS:
If the configuration file looks like this:
	3  5  16  1 : 1
(the ``3  5  8'' is due to sysctl.h only for compatibility with 2.0
kernels, and I run an 2.4.16) i get ENODIR.


--=-dlv5jHEj9+lkBRIG5jzZ
Content-Disposition: attachment; filename=sysctl.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; charset=ISO-8859-1

/**************************************************************************=
***************
**											**
** sysconf.c: Version 0.1	15.03.2002						**
**											**
** Author:	Frank Schaefer <frank.schafer@setuza.cz>				**
**											**
** Purpose:										**
**  For security reasons we decided NOT to enable procfs on our firewall.		=
**
**  Thus we had to realize an alternative for the settings of kernel parame=
ters.	**
**  Also for security reasons this program doesn't take any parameters, and=
 all paths	**
**  etc. will be hardcoded into this program.						**
**											**
** Files:										**
**	Configuration file for sysctl:	/etc/sysconf.conf				**
**											**
** Configuration file syntax:								**
**	- lines starting with a whitespace and lines starting with '#' are comme=
nts	**
**	  empty lines are comnments							**
**		<#> :	integer								**
**		<ws>:	whitespace							**
**  <#>[<ws>[<ws>...[<#><ws>[<ws>...]...]]]:[<ws>...]<#>[<ws>...[<#><ws>[<w=
s>...]...]]	**
**  Whereas the part up to the colon is the syscontrol name as described in=
		**
**  /usr/include/linux/sysctl.h, and the part after the colon is the values=
 to set	**
**											**
**  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
		**
**  !!!!!!!!!! EDIT THE CONFIGURATION FILE WITH EXTREME CAUTION !!!!!!!!!!!=
		**
**  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!=
		**
**  There isn't any possibility to check correct settings at this level. In=
correct	**
**  settings can cause a complete system crash.						**
**											**
** Return value:									**
**	0:	all settings due to the configuration file succeeded			**
**	n:	number of attempts to set parameters failed				**
**											**
***************************************************************************=
**************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <linux/unistd.h>
#include <linux/types.h>
#include <linux/sysctl.h>
#include <errno.h>

/* read one line from the configuration file, ignore comments and store the=
 name and
   the value in the arrays pointed to by name and value=09
   INPUT: 	id	- filehandle
		name	- pointer to name array
		nlen	- where to store length of the name
		value	- pointer to value array
		vlen	- where to store length of the value
   OUTPUT:	0 : O.K. name and value contain the next parameter to set
		1 : end of configuratin file reached name and value doesn't make
		    sense								*/
int readconf( FILE* id, int* name, int* nlen, int* value, int* vlen ) {
char		*buf, *buffer;
unsigned char	indx;
int		v_indx =3D 0, colon =3D 0;
char		c;
int		*target =3D name;

	buf =3D malloc( 80 * sizeof( char ) );
	buffer =3D buf;
	do {
		if( ! fgets( buffer, 80 * sizeof( char ) , id ) ) {
			free( buf );
			return( 1 );
		}
	} while ( ( *buffer =3D=3D ' ' ) || ( *buffer =3D=3D '\t' ) || ( *buffer =
=3D=3D '#' ) || \
		  ( *buffer =3D=3D '\n') );
	do {
		indx =3D strspn( buffer, "0123456789" );
		if( *(buffer + indx) =3D=3D ':' ) colon =3D 1;
		*(buffer + indx) =3D '\0';
		*(target + v_indx++) =3D atoi( buffer );
		buffer =3D buffer + indx + 1;
		indx =3D strcspn( buffer, "0123456789" );
		c =3D *(buffer + indx);
		*(buffer + indx) =3D '\0';
		if( strcspn( buffer, ":" ) !=3D strlen( buffer ) ) colon =3D 1;
		*(buffer + indx) =3D c;
		buffer =3D buffer + indx;
		if( colon && ( target !=3D value ) ) {
			target =3D value;
			*nlen =3D v_indx;
			v_indx =3D 0;
		}
	} while ( strlen( buffer ) > 0 );
	*vlen =3D v_indx;
	free( buf );
	return( 0 );
}

/* Set one parameter in the OS kernel
   INPUT:	name	- pointer to the name array
		nlen	- length of the array
		value	- pointer to the value array
		vlen	- length of the array
   OUTPUT:	0	- O.K.
		-1	- error								*/
_syscall1( int, _sysctl, struct __sysctl_args *, args );
int sysctl( int* name, int nlen, void* value, size_t vlen ) {
size_t	ovlen =3D 1;
	struct __sysctl_args args =3D { name, nlen, 0, &ovlen, value, vlen };
	return _sysctl( &args );
}

int main( ) {
int	name[5], value[16], nlen, vlen, ret =3D 0;
char 	cfgfile[] =3D "/etc/sysconf.conf";
FILE*	stream;

	stream =3D fopen( cfgfile, "r" );
	if( ! stream ) {
		fprintf( stderr, "Could not read configuration file: %s\n", cfgfile );
		exit( 1 );
	}
	while( readconf( stream, name, &nlen, value, &vlen ) !=3D 1 ) {
		if( sysctl( name, nlen, (void*)value, (size_t)vlen ) ) {
			perror( "sysctl" );
			ret++;
		}
	}
	close( stream );
	exit( ret );
}


--=-dlv5jHEj9+lkBRIG5jzZ--

