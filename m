Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131145AbRAGMit>; Sun, 7 Jan 2001 07:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131186AbRAGMia>; Sun, 7 Jan 2001 07:38:30 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:41981 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S131145AbRAGMiS>; Sun, 7 Jan 2001 07:38:18 -0500
Date: Sun, 7 Jan 2001 13:38:46 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Ulrich Drepper <drepper@cygnus.com>, David Ford <david@killerlabs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] new bug report script
In-Reply-To: <m3vgrrafzs.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.30.0101071333060.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

what do you think of this fragment ?
to me, it looks sort of large, but I wanted to cover all cases..
i'm going to optimize it a little bit.


    $v_libc5 = '';
    $v_libc6 = '';

    # first, find the path of the concerning lib with the highest version
    if ( exists_prog("ldconfig") ) {
	my @ldc_out = `ldconfig -p`;
	my $found=0;
	foreach ( sort @ldc_out) {
	    m/libc\.so\.5|libc\.so\.6/ or next;
	    s/^.* \=\> //;   # i do not want the first part
	    chomp;
	    if ( m/libc\.so\.5/ ) {
		$v_libc5 = $_;
		$found = $found | 1;
	    }
	    if ( m/libc\.so\.6/ ) {
		$v_libc6 = $_;
		$found = $found | 2;
	    }
	}
	if ( ($found)%2==0 ) {
	    # path for libc5 found, extract directory name
	    my @tokens = split /\//, $v_libc5;
	    pop @tokens;
	    $v_libc5 = join '/', @tokens;
	    opendir LIBDIR, $v_libc5;
	    my @allfiles = readdir LIBDIR;
	    closedir LIBDIR;
	    $v_libc5 = 'not found';
	    foreach (sort @allfiles) {
		m/libc.so.(5\S+)/ and $v_libc5 = $1;
	    }
	} else {
	    $v_libc5 = 'not found';
	}
	if ( ($found>>1)%2==1 ) {
	    # $v_libc6 should now contain the path of the lib file
	    if (-e $v_libc6) { # is it executable ?
		$v_libc6 = `$v_libc6`;
	    } elsif ( exists_prog("strings") ) {
		$v_libc6 = `strings $v_libc6`;
	    } else  {
		$v_libc6 = 'not found';
	    }
	    $v_libc6 =~ s/.*C [lL]ibrary.+version (\S+),.*/\1/s or
		$v_libc6 = 'not found';
	} else {
	    $v_libc6 = 'not found';
	}
    } else {
	$v_libc5 = 'not found';
	$v_libc6 = 'not found';
    }




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
