Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbTCNIOg>; Fri, 14 Mar 2003 03:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbTCNIOg>; Fri, 14 Mar 2003 03:14:36 -0500
Received: from angband.namesys.com ([212.16.7.85]:16522 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263279AbTCNIO2>; Fri, 14 Mar 2003 03:14:28 -0500
Date: Fri, 14 Mar 2003 11:25:15 +0300
From: Oleg Drokin <green@namesys.com>
To: dan carpenter <error27@email.com>
Cc: linux-kernel@vger.kernel.org, smatch-discuss@lists.sf.net
Subject: Re: smatch update / 2.5.64 / kbugs.org
Message-ID: <20030314112515.A32604@namesys.com>
References: <20030307064535.20769.qmail@email.com> <20030307095307.E4600@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20030307095307.E4600@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Fri, Mar 07, 2003 at 09:53:07AM +0300, Oleg Drokin wrote:

> Actually I think these free() checks can be extended a lot, it can detect memory leaks and so on.

Ok, it took me awhile, but here is much extended version of unfree checker.
Now the biggest source of false positives is assignments to global variables and to arrays
I have more complete list of problematic places at beginning of the script, in case anyone
want to enhance it. Also it should now work with userspace code.
<shameless plug>Funnily enough, even though I started to work on this script hoping to find some
deeply hidden bugs in reiserfs, I ended up finding bugs in other filesystems instead ;)</shameless plug>

It also requires this function in smatch.pm (I see that now you have changed set_state() to allow empty
second argument, so it may be not that strictly needed now).
sub reset_state {
    my $name;
    my $i;

    $name = $_[0];

    foreach $state (@states){
        my $quotedname = quotemeta $name;
        my $temp = pop(@states);
        if ($state->{name} =~ /^$quotedname$/){
            $state->{state} = 0;
            $state->{start_line} = 0;
            return;
        }
        push @states, $temp;
    }
}


Bye,
    Oleg

--sdtB3X0nJg68CQEu
Content-Type: application/x-perl
Content-Disposition: attachment; filename="unfree-new1.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0A#=0A# This script checks to make sure no allocated memory=
 is lost.=0A# Based on great Dan Carpenter's work.=0A# Enhanced by Oleg Dro=
kin to understand missing last reference on assignments, exported stuff, eq=
uivalent variables,=0A#                          chained assignments, doubl=
e free, free of null values, assignments/returns/comparisons of=0A#			   al=
ready freed values.=0A#=0A# BUGS:=0A#   Exporting only understands indirect=
ions, there is no way to determine static local and global variables yet.=
=0A#   If the malloc/free is done conditionally on some nontrivial expressi=
on, we do not understand it. (false memleaks)=0A#   It does not know about =
switch/case=0A#   if ( (a =3D b) =3D=3D NULL) stuff is missed as a=3Db assi=
gnment.=0A#   (fixed?)No way to specify which parameter of "free" function =
is the pointer (disables e.g. kmem_cache_free tracing)=0A#   Alloc/free fun=
ctions list can be bigger=0A#   list_add alikes should be handled as one mo=
re class.=0A#   (fixed?)Various list_add stuff that makes variable to not b=
e lost is not handled yet.=0A#   a[i]=3Dkmalloc() ; i++ ; a[i]=3Dsmth; prod=
uces false "memleak" warning.=0A#=0A=0Ause smatch;=0Ause ifcond;=0A=0A# Set=
 this to 1, if your functions are not supposed to export any stuff=0A# on r=
eturning negative values (errors?). This produces lots of false positives,=
=0A# but it also catches some real bugs, so you probably want to try with a=
nd without this setting.=0A$EXPORTED_ON_EXIT_IS_BAD =3D 0;=0A=0A# Set this =
to 1 to mark variables passed to other functions by address as "exported"=
=0A# (not reported as leaked later on). Set to 0 otherwise=0A$REFERENCE_BY_=
ADDRESS_IS_EXPORTED =3D 1;=0A=0A# Enable list_funcs functions=0A$ENABLE_LIS=
T_FUNCS =3D 1;=0A=0A# These functions return pointer to newly allocated mem=
ory.=0Amy (@alloc_funcs) =3D ("kmalloc","vmalloc","malloc","alloc","calloc"=
);=0A=0A# These functions take only one argument and "free" it.=0Amy (@free=
_funcs) =3D ("kfree","vfree","free","netlink_destroy_callback", "unix_relea=
se_addr", "free_fib_info", "free_msg","c101_destroy_card","n2_destroy_card"=
,"bsd_free");=0A=0A# These functions take multiple aruments, if any of trac=
ked vars is passed to such functions,=0A# it is marked as "exported" (so we=
 do not report it as leaked on function exit).=0Amy (@list_funcs) =3D ("lis=
t_add","list_add_tail","dev_set_drvdata","pci_set_drvdata","setup_irq","seq=
_open","__sound_insert_unit","ext3_xattr_rehash","translate_table","release=
_stripe","submit_command","submit_queue","idetape_setup","ntfs_index_writeb=
ack","ntfs_new_attr","autofs_hash_insert","hashbin_insert","__grp_hash","aw=
c_fid_queue_push_tail","i596_add_cmd","mtdram_init_device","acpi_os_schedul=
e_exec","agp_add_seg_to_client","parport_register_device","n_hdlc_buf_put",=
"add_rx_queue","add_tx_queue","notify_enqueue","DC390_queue_command","aha15=
2x_internal_queue","ips_putq_copp_tail","ahc_alloc","i2c_attach_client","ta=
sklet_init","initMatrox2","i2o_install_device","mpt_free_fw_memory","add_ne=
w_bus","ibmphp_hpc_fillhpslotinfo","ibmphp_add_resource");=0A=0Asub error_m=
sg{=0A    my $msg =3D shift;=0A    my $var =3D shift;=0A    print get_filen=
ame(), " ", get_start_line($var), " ", get_lineno(), " ", get_func_pos(), "=
 $msg\n";=0A}=0A=0A# These merge rules are grown from real observation on L=
inux kernel sources.=0Asub merge_pointer_states($$$){=0A    my ($name, $one=
, $two) =3D @_;=0A=0A    if ( ($one eq "free" && $two eq "null") || ($one e=
q "null" && $two eq "free") ) {=0A	return "free";=0A    }=0A    if ( ($one =
eq "free" && $two eq "non_null") || ($one eq "non_null" && $two eq "free") =
) {=0A	return "non_null";=0A    }=0A    # ??? This is uncertain.=0A#    if =
( ($one eq "free" && $two eq "undefined") || ($one eq "undefined" && $two e=
q "free") ) {=0A#	return "free";=0A#    }=0A    if ( ($one =3D~ /(copy of .=
*)/ && $two eq "free") || ($one eq "free" && $two =3D~ /(copy of .*)/) ) {=
=0A	return "free";=0A    }=0A    if ( ($one =3D~ /(copy of .*)/ && $two eq =
"non_null") || ($one eq "non_null" && $two =3D~ /(copy of .*)/) ) {=0A	retu=
rn $1;=0A    }=0A    if ( ($one =3D~ /(copy of .*)/ && $two eq "null") || (=
$one eq "null" && $two =3D~ /(copy of .*)/) ) {=0A	return $1;=0A    }=0A   =
 if ( ($one =3D~ /(copy of .*)/ && $two eq "undefined") || ($one eq "undefi=
ned" && $two =3D~ /(copy of .*)/) ) {=0A	return $1;=0A    }=0A    if ( ($on=
e eq "exported" && $two eq "null") || ($one eq "null" && $two eq "exported"=
) ) {=0A	return "exported";=0A    }=0A    if ( ($one eq "exported" && $two =
eq "non_null") || ($one eq "non_null" && $two eq "exported") ) {=0A	return =
"exported";=0A    }=0A    # ??? I am not sure, but it seems that if we retu=
rn "free" here, we will hit lots of false stuff=0A    if ( ($one eq "export=
ed" && $two eq "free") || ($one eq "free" && $two eq "exported") ) {=0A	ret=
urn "exported";=0A    }=0A    if ( ($one eq "exported" && $two eq "undefine=
d") || ($one eq "undefined" && $two eq "exported") ) {=0A	return "exported"=
;=0A    }=0A    if ( ($one eq "copied" && $two eq "null") || ($one eq "null=
" && $two eq "copied") ) {=0A	return "copied";=0A    }=0A    if ( ($one eq =
"copied" && $two eq "non_null") || ($one eq "non_null" && $two eq "copied")=
 ) {=0A	return "copied";=0A    }=0A    if ( ($one eq "copied" && $two eq "f=
ree") || ($one eq "free" && $two eq "copied") ) {=0A	return "free";=0A    }=
=0A    if ( ($one eq "copied" && $two eq "underfined") || ($one eq "copied"=
 && $two eq "underfined") ) {=0A	return "copied";=0A    }=0A    if ( ($one =
eq "exported" && $two eq "copied") || ($one eq "copied" && $two eq "exporte=
d") ) {=0A	return "copied";=0A    }=0A    return merge_rules($name, $one, $=
two);=0A}=0Asub merge_rules($$$){=0A    my ($name, $one, $two) =3D @_;=0A=
=0A    # there are two kinds of states here.=0A    # ones that end in __fun=
ction that store the=0A    # the name of the function that possibly returne=
d null.=0A    #=0A    # we treat each type of state differently but in this=
 =0A    # case we want to treat them both the same.=0A=0A    if ($one =3D~ =
/^__none$/){=0A	return $two;=0A    }=0A    if ($two =3D~ /^__none$/){=0A	re=
turn $one;=0A    }=0A=0A    my $quoted_two =3D quotemeta $two;=0A    if ($o=
ne =3D~ /^$quoted_two$/){=0A	return $one;=0A    }=0A=0A    return "undefine=
d";=0A}=0Aadd_merge_function("merge_pointer_states");=0A=0Asub dereference_=
and_get_var_value($) {=0A    my ($var) =3D $_[0];=0A=0A    if ( $var =3D~ /=
copy of (.*) / ) {=0A	return get_state($1);=0A    } else {=0A	return get_st=
ate($var);=0A    }=0A}=0A=0A# this is mostly used from if statements=0Asub =
dereference_and_set_var_value{=0A    my ($var) =3D $_[0];=0A    my ($new_va=
lue) =3D $_[1];=0A    my ($conditional) =3D $_[2];=0A=0A    if ( get_state(=
$var) =3D~ /copy of (.*)/ ) {=0A	$var =3D $1;=0A    }=0A=0A    # do not loo=
se "exported" stuff on conditions=0A    if ( get_state($var) eq "exported" =
&& ($new_value eq "non_null" || $new_value eq "null") ) {=0A	return;=0A    =
}=0A=0A    if ( get_state($var) ne "free" ) {=0A	if ( $conditional ) {=0A	 =
   if ( $conditional eq "true") {=0A		set_true_path($var, $new_value);=0A	 =
   }=0A	    if ( $conditional eq "false") {=0A		set_false_path($var, $new_v=
alue);=0A	    }=0A	} else {=0A	    set_state($var, $new_value);=0A	}=0A    =
}=0A}=0A=0Asub remove_one_var_copy {=0A	my ($var) =3D $_[0];=0A	my ($vars);=
=0A=0A	# See if there is nothing to keep track of.=0A	if ( get_state($var) =
=3D~ /copy of (.*)/) {=0A	    my ($temp) =3D $var;=0A	    $var =3D $1;=0A	 =
   set_state($temp,get_state($var));=0A	} else {=0A	    return;=0A	}=0A=0A	=
# if this is free already, no need to make it exported/copied.=0A	if ( get_=
state($var) eq "free" ) {=0A	    return=0A	}=0A	set_state($var, "undefined"=
);=0A	# Ok, let's see if there any variables holding same data as this one =
left.=0A	foreach $vars (state_names()){=0A=0A	    if ( get_state($vars) eq =
"copy of $var") {=0A		if ( $vars =3D~ /indirect_ref/ ) {=0A		    set_state(=
$var, "exported");=0A		    return;=0A		} else {=0A		    set_state($var, "co=
pied");=0A		}=0A	    }=0A	}=0A	return;=0A}=0A=0Asub unchain_variable {=0A	m=
y ($var) =3D $_[0];=0A	my ($vstate) =3D get_state($var);=0A	my ($vars);=0A	=
my ($replace) =3D "";=0A=0A	# See if there is nothing to keep track of.=0A	=
if ( $vstate ne "copied" && $vstate ne "exported") {=0A	    return;=0A	}=0A=
	# Ok, let's see if there any variables holding same data as this one left.=
=0A	foreach $vars (state_names()){=0A=0A	    if ( get_state($vars) eq "copy=
 of $var") {=0A		if ( $replace ) {=0A		    set_state($vars, "copy of $repla=
ce");=0A		} else {=0A		    set_state($vars, "undefined");=0A		    $replace =
=3D $vars;=0A		}=0A	    }=0A	}=0A	return;=0A}=0A=0A# Takes left and right p=
arts of assignment=0Asub handle_assignment ($$){=0A	my($src) =3D $_[0];=0A	=
my ($dest) =3D $_[1];=0A	my ($sstate) =3D get_state($src);=0A	my ($dstate) =
=3D get_state($dest);=0A=0A#print "$data\n";=0A#print "$src, $dest, $sstate=
, $dstate\n";=0A	# a =3D b =3D c =3D ...=0A	if ($src =3D~ /modify_expr\((.*=
?)\=3D (.*)\)/) {=0A	    $src =3D $1;=0A	    # Yeah, it's recursion.=0A	   =
 handle_assignment( $2, $src);=0A	    $sstate =3D get_state($src);=0A	}=0A=
=0A	# function call=0A	if ($src =3D~ /^call_expr\(\(addr_expr function_decl=
\((\w+?)\)/){=0A	    my ($function) =3D quotemeta($1);=0A	    my ($fn);=0A	=
    foreach $fn (@alloc_funcs) {=0A		if ($function eq $fn){=0A		    set_sta=
te ($dest, "undefined");=0A#		    set_state ("$dest #__function", $function=
);=0A		}=0A	    }=0A	}=0A=0A	# Hm. Handle a =3D do_something(a); stuff. Thi=
s shot down number of false positives=0A	if ( !($src =3D~ /\Q$dest\E/) ) {=
=0A	    if ( $dstate eq "undefined" || $dstate eq "non_null" ) {=0A		error_=
msg("Probably leaking memory, $dest is $dstate", $dest);=0A	    }=0A	    un=
chain_variable($dest);=0A	    remove_one_var_copy($dest);=0A	}=0A=0A	if ($s=
state){=0A	    if ( $sstate eq "free") {=0A		error_msg("Assigning freed poi=
nter $src to $dest", $src);=0A	    }=0A	    if ( $sstate ne "null" ) {=0A		=
if ( $sstate =3D~ /copy of (.*)/ ) {=0A		    $src =3D $1;=0A		    $sstate =
=3D get_state($src);=0A		}=0A		if ( $dest =3D~ /indirect_ref/ || $dest =3D~=
 /array_ref/ ) {=0A		    set_state($src, "exported");=0A		} else {=0A		    =
# If we copy already exported var to local var,=0A		    # it is still expor=
ted ;)=0A		    if ( $sstate ne "exported" ) {=0A			set_state($src, "copied"=
);=0A		    }=0A		}=0A		set_state ($dest, "copy of $src");=0A	    } else {=
=0A		set_state ($dest, $sstate);=0A	    }=0A	} else { if ( $src =3D~ /^inte=
ger_cst\((\w+)\)/ ) {=0A		my ($const) =3D $1;=0A		if ( $dstate ) {=0A		    =
if ( $const eq "0" ) {=0A			set_state ($dest, "null");=0A		    } else {=0A	=
		reset_state ($dest);=0A		    }=0A		}=0A	}}=0A=0A}=0A=0Awhile ($data =3D g=
et_data()){=0A    my $tmp;=0A=0A    # if we modify something then we just g=
oing to set the start to non_null=0A    # temporarilly.  Then maybe later s=
et it to undefined.=0A#    if ($data =3D~ /expr_stmt modify_expr\((.*?)\=3D=
 /){=0A#	$variable =3D $1;=0A#	if (get_state($variable)){=0A#	    set_state=
 ($variable, "non_null");=0A#	}=0A#    }=0A=0A    # We need to track when p=
ointers are passed to other variables.=0A    # We need to see if these are =
externally visible or not and so on.=0A    if ($data =3D~ /expr_stmt modify=
_expr\((.*?)\=3D (.*)\)/){=0A	my($src) =3D $2;=0A	my ($dest) =3D $1;=0A=0A	=
handle_assignment($src,$dest);=0A    }=0A=0A    # Var declaration with valu=
e assignment=0A    if ($data =3D~ /^var_decl\(.*?_type (.*?) =3D (.*)\)/ ) =
{=0A	my($src) =3D $2;=0A	my ($dest) =3D "var_decl($1)";=0A=0A	reset_state($=
dest);=0A	handle_assignment($src,$dest);=0A    }=0A=0A    # func (&var) and=
 func(&var->field); case=0A    if ( $REFERENCE_BY_ADDRESS_IS_EXPORTED && $d=
ata =3D~ /call_expr\(.*function_decl\((.*?)\).*\(tree_list: (.*)/ ) {=0A	my=
 ($expr) =3D $2;=0A	my ($function) =3D $1;=0A	my ($vars);=0A=0A	# Special c=
ase various atomic/spinlock and so on stuff that is often=0A	# used with va=
riable pointers, but does not export stuff.=0A	foreach $vars (state_names()=
){=0A	    # See if we pass some of tracked stuff there=0A	    if ( $expr =
=3D~ /addr_expr \Q$vars\E/ || $expr =3D~ /non_lvalue_expr \Q$vars\E/) {=0A	=
	if ( get_state($vars) eq "free" ) {=0A		    error_msg("Possibly passing fr=
eed value to function $vars, $function","$vars");=0A		} else {=0A		    if (=
 !($function =3D~ /^(atomic_|spin_)/ ) ) {=0A			dereference_and_set_var_val=
ue( $vars,"exported","");=0A		    }=0A		}=0A	    } else {=0A		if ($vars =3D=
~ /component_ref\(\((.*?)\)\(/ ) {=0A		    my ($var) =3D $1;=0A		    if ( $=
expr =3D~ /addr_expr \Q$var\E/ || $expr =3D~ /non_lvalue_expr \Q$var\E/) {=
=0A			if ( get_state($vars) eq "free" ) {=0A			    error_msg("Possibly pass=
ing pointer freed value to function $vars","$vars");=0A			} else {=0A			   =
 if ( !($function =3D~ /^(atomic_|spin_)/ ) ) {=0A				dereference_and_set_v=
ar_value( $vars,"exported","");=0A			    }=0A			}=0A		    }=0A		}=0A		if ($=
vars =3D~ /component_ref\(\(indirect_ref (.*?)\)\(/ ) {=0A		    my ($var) =
=3D $1;=0A		    if ( $expr =3D~ /addr_expr \Q$var\E/ || $expr =3D~ /non_lva=
lue_expr \Q$var\E/) {=0A			if ( get_state($vars) eq "free" ) {=0A			    err=
or_msg("Possibly passing pointer to freed value (part of structure) to func=
tion $vars","$vars");=0A			} else {=0A			    if ( !($function =3D~ /^(atomi=
c_|spin_)/ ) ) {=0A				dereference_and_set_var_value( $vars,"exported","");=
=0A			    }=0A			}=0A		    }=0A		}=0A	    }=0A	}=0A=0A    }=0A=0A    # list=
_add alikes=0A    if ( $ENABLE_LIST_FUNCS && $data =3D~ /call_expr\(.*funct=
ion_decl\((.*?)\).*\(tree_list: (.*)\)/ ) {=0A	my ($func) =3D $1;=0A	my ($a=
rgs) =3D $2;=0A=0A	# See if this is call to one of matching functions=0A	if=
 ( grep(/^$func$/, @list_funcs) ) {=0A	    my ($vars);=0A	    foreach $vars=
 (state_names()){=0A		# See if we pass some of tracked stuff there=0A		if (=
 $args =3D~ /\Q$vars\E/ ) {=0A		    if ( get_state($vars) eq "free" ) {=0A	=
		error_msg("Possibly passing freed value of $vars to function $func","$var=
s");=0A		    } else {=0A			dereference_and_set_var_value( $vars,"exported",=
"");=0A		    }=0A		}=0A	    }=0A	}=0A    }=0A=0A#    if ( $data =3D~ /funct=
ion_decl\(list_add.*\)\)\(tree_list: (.*?),.*/ ) {=0A#	my ($var) =3D $1;=0A=
#	if ( get_state($var) ) {=0A#	    dereference_and_set_var_value( $var,"exp=
orted","");=0A#	}=0A#    }=0A=0A    # if we see "foo =3D kmalloc ()" then w=
e store foo=0A    # as "undefined"=0A    #modify_expr(var_decl(foo)=3D call=
_expr((addr_expr function_decl(.*alloc))()))=0A#    if ($data =3D~ /expr_st=
mt modify_expr\((.*?)\=3D call_expr\(\(addr_expr function_decl\((\w+?)\)/){=
=0A#	$variable =3D $1;=0A#	$function =3D quotemeta($2);=0A#	#if (`grep ^$fu=
nction\$ list_null_funcs_uniq`){=0A#	if ($function =3D~/^.*alloc$/){=0A#	  =
  #print get_filename(), " ", get_lineno(), " ", "$variable undefined";=0A#=
	    set_state ($variable, "undefined");=0A#	    set_state ("$variable __fu=
nction", $function);=0A#	}=0A#    }=0A=0A    # split_conds is from ifcond.p=
m.  It simplifies handling of compound conditions=0A    # for example:=0A  =
  # if (!a || !b) { tells us that on the false path a is non_null=0A    # i=
f (a && b) { tells us that on the true path a is non_null=0A    =0A    # it=
 turns out that it is important to check for_statements as well.=0A    # a =
lot of code does stuff like for( ; foo =3D next_token(); ){=0A=0A    if (($=
data =3D~ /^(if_cond|while_cond) (.*)/) || ($data =3D~ /^(for_stmt).*?; (.*=
?);/)){=0A	my %conds =3D split_conds($2);=0A=0A	for my $cond (@{$conds{true=
path}}){=0A	    if ($cond =3D~ /^compound_cond/){=0A		next;=0A	    }=0A=0A	=
    if ($cond =3D~ /eq_expr\(\((.*)\)\(integer_cst\(0\)\)\)/){=0A		my $name=
 =3D $1;=0A		if (get_state ($name)){=0A		    dereference_and_set_var_value(=
$name,"null", "true");=0A		}=0A	    }elsif(($cond =3D~ /ne_expr\(\((.*)\)\(=
integer_cst\(0\)\)\)/) ||=0A		   ($cond =3D~/(.*)/)){=0A		my $name =3D $1;=
=0A		if (get_state ($name)) { =0A		    if ( dereference_and_get_var_value (=
$name) eq "free"){=0A			error_msg("Comparing value of freed $name", $name);=
=0A		    } else { if ( dereference_and_get_var_value ($name) eq "non_null" =
) {=0A			error_msg("Redundant always true comparison on $name", $name);=0A	=
	    } else {=0A			dereference_and_set_var_value($name,"non_null","true");=
=0A		    }}=0A		}=0A	    }=0A	    if ( ! ($cond =3D~ /_expr/) ) {=0A		if (g=
et_state ($name)) { =0A		    if ( dereference_and_get_var_value ($name) eq =
"free"){=0A			error_msg("Comparing value of freed $name", $name);=0A		    }=
 else { if ( dereference_and_get_var_value ($name) eq "non_null" ) {=0A			e=
rror_msg("Redundant always true comparison on $name", $name);=0A		    } els=
e {=0A			dereference_and_set_var_value($name,"non_null","true");=0A		    }}=
=0A		}=0A	    }=0A	}=0A	for my $cond (@{$conds{falsepath}}){=0A=0A	    if (=
$cond =3D~ /^compound_cond/){=0A		next;=0A	    }=0A=0A	    if ($cond =3D~ /=
eq_expr\(\((.*)\)\(integer_cst\(0\)\)\)/){=0A		my $name =3D $1;=0A		if (get=
_state ($name)) { =0A		    if ( dereference_and_get_var_value ($name) eq "f=
ree"){=0A			error_msg("Comparing value of freed $name", $name);=0A		    } e=
lse { if ( dereference_and_get_var_value ($name) eq "non_null" ) {=0A			err=
or_msg("Redundant always true comparison on $name", $name);=0A		    } else =
{=0A			dereference_and_set_var_value($name,"non_null","false");=0A		    }}=
=0A		}=0A	    }elsif(($cond =3D~ /ne_expr\(\((.*)\)\(integer_cst\(0\)\)\)/)=
 ||=0A		   ( $cond =3D~/(.*)/)){=0A		my $name =3D $1;=0A		if (get_state ($n=
ame)) { =0A		    if ( dereference_and_get_var_value ($name) eq "free"){=0A	=
		error_msg("Comparing value of freed $name", $name);=0A		    } else { if (=
 get_state ($name) eq "null" ) {=0A			error_msg("Redundant always true comp=
arison on $name", $name);=0A		    } else {=0A			dereference_and_set_var_val=
ue($name,"null","false");=0A		    }}=0A		}=0A	    }=0A	    if ( ! ($cond =
=3D~ /_expr/) ) {=0A		if (get_state ($name)) { =0A		    if ( dereference_an=
d_get_var_value ($name) eq "free"){=0A			error_msg("Comparing value of free=
d $name", $name);=0A		    } else { if ( get_state ($name) eq "null" ) {=0A	=
		error_msg("Redundant always true comparison on $name", $name);=0A		    } =
else {=0A			dereference_and_set_var_value($name,"null","false");=0A		    }}=
=0A		}=0A	    }=0A	}=0A    }elsif ($data =3D~ /^(do_cond) (.*)/){          =
  # check do while() for thouroughness=0A	$conds =3D split_conds($1);=0A	fo=
r my $cond (@{$conds{falsepath}}){=0A	    if ($cond =3D~ /^compound_cond/){=
=0A		next;=0A	    }=0A=0A	    if ($cond =3D~ /eq_expr\(\((.*)\)\(integer_cs=
t\(0\)\)\)/){=0A		my $name =3D $1;=0A		if (get_state ($name)) { =0A		    if=
 ( get_state ($name) eq "free"){=0A			error_msg("Comparing value of freed $=
name", $name);=0A		    } else { if ( get_state ($name) eq "non_null" ) {=0A=
			error_msg("Redundant always true comparison on $name", $name);=0A		    }=
 else {=0A			dereference_and_set_var_value($name,"non_null","");=0A		    }}=
=0A		}=0A	    }elsif(($cond =3D~ /ne_expr\(\((.*)\)\(integer_cst\(0\)\)\)/)=
 ||=0A		   ( $cond =3D~/(.*)/)){=0A		my $name =3D $1;=0A		if (get_state ($n=
ame)) { =0A		    if ( get_state ($name) eq "free"){=0A			error_msg("Compari=
ng value of freed $name", $name);=0A		    } else { if ( get_state ($name) e=
q "null" ) {=0A			error_msg("Redundant always true comparison on $name", $n=
ame);=0A		    } else {=0A			dereference_and_set_var_value($name,"null", "")=
;=0A		    }}=0A		}=0A	    }=0A	}=0A	if ( ! ($cond =3D~ /_expr/) ) {=0A		if =
(get_state ($cond)) { =0A		    if ( get_state ($cond) eq "free"){=0A			erro=
r_msg("Comparing value of freed $cond", $cond);=0A		    } else { if ( get_s=
tate ($cond) eq "null" ) {=0A			error_msg("Redundant always true comparison=
 on $cond", $cond);=0A		    } else {=0A			dereference_and_set_var_value($co=
nd,"null","");=0A		    }}=0A		}=0A	}=0A    }=0A    =0A    if ($data =3D~ /c=
all_expr\(\(addr_expr function_decl\((\w+?)\)\)\(tree_list: (.*)\)\)/){=0A	=
my ($fn);=0A	my ($function) =3D $1;=0A	my $var =3D $2;=0A	foreach $fn (@fre=
e_funcs) {=0A	    if ( $function eq $fn) {=0A		my $state =3D get_state($var=
);=0A		if ( $state eq "null" ) {=0A		    error_msg("Freeing null pointer $v=
ar", $var);=0A		}=0A		if ( $state eq "free" ) {=0A		    error_msg("Freeing =
already freed $var", $var);=0A		}=0A		# We are supposed to catch this case =
on return now=0A		#if ( $state eq "exported" ) {=0A		#    error_msg("Freein=
g externally visible $var", $var);=0A		#}=0A		if ($state){=0A		    set_stat=
e($var, "free");=0A		    # Also free all the vars that refer to same place=
=0A		    if ( $state eq "copied" || $state eq "exported") {=0A			my ($vars)=
;=0A			foreach $vars (state_names()){=0A			    if ( get_state($vars) eq "co=
py of $var") {=0A				set_state($vars, "free");=0A			    }=0A			}=0A		    }=
=0A		    if ( $state =3D~ /copy of (.*)/) {=0A			my ($ref) =3D $1;=0A			my =
($vars);=0A			set_state($ref, "free");=0A			foreach $vars (state_names()){=
=0A			    if ( get_state($vars) eq "copy of $ref") {=0A				set_state($vars,=
 "free");=0A			    }=0A			}=0A		    }=0A		}=0A	    }=0A	}=0A    }=0A=0A    =
if ( $data =3D~ /^return_stmt modify_expr\(result_decl (.*)/ || $data eq "e=
nd_func" ) {=0A	my ($retval) =3D $1;=0A	my ($var);=0A	# cast return value t=
o something case=0A	if ( $retval =3D~ /^.*_type =3D (.*)\)$/ ) {=0A	    $re=
tval =3D $1;=0A	}=0A	foreach $var (state_names()){=0A	    my $state =3D get=
_state($var);=0A	    if ( $state =3D~ /^(non_null|undefined|copied)/ && !($=
var =3D~ /indirect_ref/) ) {=0A		# If we do not return this, then we leak i=
t.=0A		if ( ! ($retval =3D~ /\Q$var\E/) && ! (get_state($retval) eq "copy o=
f $var" )) {=0A		    my $msg =3D "Probably leaking memory: $var" . " unfree=
d " . $state;=0A		    error_msg($msg, $var);=0A		}=0A	    }=0A	    # See if=
 we exporting anything freed outside=0A	    if ( $state =3D~ /copy of (.*)/=
 && $var =3D~ /indirect_ref/ ) {=0A		my ($ref) =3D $1;=0A		if ( get_state($=
ref) eq "free" ) {=0A		    error_msg("Freed pointer is visible from outside=
 $var", $ref);=0A		}=0A	    }=0A		=0A	    if ( $retval =3D~ /\Q$var\E/ ) {=
=0A		if ($state eq "free" ){=0A		    error_msg("Returning with freed result=
 $var",$var);=0A		}=0A	    }=0A=0A	}=0A    }=0A=0A    # if it returns a neg=
ative constant or a NULL then it is an error path which need some special t=
hreatment=0Aif ( $EXPORTED_ON_EXIT_IS_BAD ) {=0A    if (($data =3D~ /^retur=
n_stmt modify_expr\(result_decl integer_type =3D integer_cst\(-\d+\)\)/)=0A=
	or ($data =3D~ /^return_stmt modify_expr\(result_decl pointer_type =3D int=
eger_cst\(0\)\)/)){=0A	my $state;=0A	foreach $state (state_names()){=0A	   =
 my $state_state =3D get_state($state);=0A	    if ($state_state =3D~ /^(non=
_null|undefined|exported|copied)/){=0A		my $msg =3D $state . " unfreed " . =
$state_state;=0A		error_msg($msg, $state);=0A	    }=0A	}=0A    }=0A}=0A}=0A
--sdtB3X0nJg68CQEu--
